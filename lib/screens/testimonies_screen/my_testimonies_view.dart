import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/screens/testimonies_screen/create_testimony_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//TODO: overflow error on no testimonies image on small screen
class MyTestimoniesView extends StatefulWidget {
  const MyTestimoniesView({Key? key}) : super(key: key);

  @override
  State<MyTestimoniesView> createState() => _MyTestimoniesViewState();
}

class _MyTestimoniesViewState extends State<MyTestimoniesView> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kBodyPadding,
        vertical: kBodyPadding,
      ),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('testimonies').snapshots(),
        builder: (context, snapshot) {
          List<TestimonyInfo> allTestmonies = [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            // also add image
            return const Center(
              child: Text('Please try again', style: kSFBody),
            );
          }

          if (snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return Column(
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

          //user has added not testimonies
          //the testimony list is empty
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
            physics: const BouncingScrollPhysics(),
            itemCount: allTestmonies.length,
            separatorBuilder: (context, index) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              return TestimonyCard(
                editable: true,
                title: allTestmonies[index].title,
                testimony: allTestmonies[index].testimony,
                likes: allTestmonies[index].likes,
                date: allTestmonies[index].date,
                cardColor: Color(
                  int.parse(allTestmonies[index].cardColor.toString()),
                ),
                onPressedLike: () {},
                onPressedCard: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreateTestimonyScreen(
                      editable: true,
                      testimonyInfo: allTestmonies[index],
                    );
                  }));
                },
              );
            },
          );
        },
      ),
    );
  }
}
