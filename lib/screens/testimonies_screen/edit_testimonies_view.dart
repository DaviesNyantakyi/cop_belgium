import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/error_views.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditTestimoniesView extends StatefulWidget {
  const EditTestimoniesView({Key? key}) : super(key: key);

  @override
  State<EditTestimoniesView> createState() => _EditTestimoniesViewState();
}

class _EditTestimoniesViewState extends State<EditTestimoniesView> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  Future<void> tryAgain() async {
    try {
      isLoading = true;
      if (mounted) {
        setState(() {});
      }
      EasyLoading.show();
    } on FirebaseException catch (e) {
      kshowSnackbar(
        context: context,
        errorType: 'error',
        text: e.message.toString(),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
      isLoading = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kBodyPadding,
        vertical: kBodyPadding,
      ),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('testimonies')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          List<TestimonyInfo> allTestmonies = [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const TestimoniesViewShimmer();
          }

          if (snapshot.hasError) {
            return TryAgainView(
              btnColor: isLoading ? kGrey : kYellowDark,
              onPressed: isLoading ? null : tryAgain,
            );
          }

          if (snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return const NoTestimonyView();
            }
          }

          for (var doc in snapshot.data!.docs) {
            final testimony = TestimonyInfo.fromMap(map: doc.data());

            // if current user id matches TestimonyInfo id add to list
            if (testimony.userId == currentUser!.uid) {
              allTestmonies.add(testimony);
            }
          }

          //user has added not testimonies
          //the testimony list is empty
          if (allTestmonies.isEmpty) {
            return const NoTestimonyView();
          }

          return ListView.separated(
            itemCount: allTestmonies.length,
            separatorBuilder: (context, index) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              return TestimonyCard(
                editable: true,
                testimonyInfo: allTestmonies[index],
                onPressedEdit: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return CreateTestimonyScreen(
                      editable: true,
                      testimonyInfo: allTestmonies[index],
                    );
                  }));
                },
                onPressedCard: () {
                  _showBottomSheet(
                    context: context,
                    title: allTestmonies[index].title!,
                    testimony: allTestmonies[index].description!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showBottomSheet({
    required BuildContext context,
    required String title,
    required String testimony,
  }) {
    return showMyBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              testimony,
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }
}
