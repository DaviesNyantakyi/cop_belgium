import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';

class TestimoniesView extends StatefulWidget {
  const TestimoniesView({Key? key}) : super(key: key);

  @override
  State<TestimoniesView> createState() => _TestimoniesViewState();
}

class _TestimoniesViewState extends State<TestimoniesView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kBodyPadding, vertical: kBodyPadding),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Testimonies')
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
                    Image.asset(
                      'assets/images/add_testimony.png',
                      height: 220,
                      width: 220,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Be the first to add a testimony',
                      style: kSFBody,
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/error.png',
                  height: 220,
                  width: 220,
                ),
                const Text('OOops', style: kSFHeadLine1),
                const Text('Something went wrong.', style: kSFBody),
                const SizedBox(height: 30),
                Buttons.buildBtn(
                  context: context,
                  btnText: 'Try again',
                  onPressed: () {
                    //TODO: add try again option
                  },
                ),
              ],
            );
          }

          final listDocQSnap = snapshot.data!.docs;

          for (var doc in listDocQSnap) {
            allTestimonies.add(TestimonyInfo.fromMap(map: doc.data()));
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 15),
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
