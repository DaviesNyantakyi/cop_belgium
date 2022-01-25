import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/error_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//TODO: fix: if a testimony field is null in firbase then have an error
class TestimoniesView extends StatefulWidget {
  const TestimoniesView({Key? key}) : super(key: key);

  @override
  State<TestimoniesView> createState() => _TestimoniesViewState();
}

class _TestimoniesViewState extends State<TestimoniesView> {
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
          horizontal: kBodyPadding, vertical: kBodyPadding),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('testimonies')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          List<TestimonyInfo> allTestimonies = [];

          if (snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Image.asset(
                        'assets/images/add_testimony.png',
                        height: 220,
                        width: 220,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        'Be the first to add a testimony',
                        style: kSFBody,
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return TryAgainView(
              btnColor: isLoading ? kGrey : kYellowDark,
              onPressed: isLoading ? null : tryAgain,
            );
          }

          final listDocQSnap = snapshot.data!.docs;

          for (var doc in listDocQSnap) {
            allTestimonies.add(TestimonyInfo.fromMap(map: doc.data()));
          }

          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
            itemCount: allTestimonies.length,
            itemBuilder: (context, index) {
              return TestimonyCard(
                testimonyInfo: allTestimonies[index],
                onPressedCard: () {
                  _showBottomSheet(
                    context: context,
                    title: allTestimonies[index].title!,
                    testimony: allTestimonies[index].description!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
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
