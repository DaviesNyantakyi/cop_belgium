import 'package:cop_belgium/screens/testimonies_screen/create_testimony_screen.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class MyTestimoniesView extends StatefulWidget {
  const MyTestimoniesView({Key? key}) : super(key: key);

  @override
  State<MyTestimoniesView> createState() => _MyTestimoniesViewState();
}

class _MyTestimoniesViewState extends State<MyTestimoniesView> {
  int likes = 255;
  Color cardColor = kRedLight2;
  String title = 'Announcements Lorem ipsum';
  String testimony =
      'Consequat magna fugiat dolor sit aliquip ksnkfqnfkqnf qnlfkqfknfanlan alfalknfkncksqnfk lqfnaplfnckzlfnzflfnndqd,aveisc davis';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 20,
        padding: const EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: TestimonyCard(
              editable: true,
              title: title,
              testimony: testimony,
              likes: likes,
              cardColor: cardColor,
              timeAgo: '6 Hours Ago',
              onPressedLike: () {
                setState(() {
                  likes++;
                });
              },
              onPressedCard: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CreateTestimonyScreen(
                        editable: true,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
