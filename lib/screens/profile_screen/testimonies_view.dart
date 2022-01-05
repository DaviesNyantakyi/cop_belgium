import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/screens/testimonies_screen/create_testimony_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/error_views.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserTestimoniesView extends StatefulWidget {
  static String userTestimoniesView = 'userTestimoniesView';

  const UserTestimoniesView({Key? key}) : super(key: key);

  @override
  State<UserTestimoniesView> createState() => _UserTestimoniesViewState();
}

class _UserTestimoniesViewState extends State<UserTestimoniesView> {
  User? currentUser = FirebaseAuth.instance.currentUser;

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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return TryAgainView(
              onPressed: () {
                setState(() {});
              },
            );
          }

          if (snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/create_testimony.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Expanded(
                    child: Text(
                      'You have no testimonies',
                      style: kSFBody,
                    ),
                  ),
                ],
              );
            }
          }

          for (var doc in snapshot.data!.docs) {
            final testimony = TestimonyInfo.fromMap(map: doc.data());

            // if current user id matches TestimonyInfo id add to list
            if (testimony.userId == currentUser!.uid) {
              allTestmonies.add(testimony);
            }
          }

          if (allTestmonies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/create_testimony.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'You have no testimonies',
                    style: kSFBody,
                  ),
                ],
              ),
            );
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
