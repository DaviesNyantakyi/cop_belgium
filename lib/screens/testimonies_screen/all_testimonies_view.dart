import 'dart:math';

import 'package:cop_belgium/screens/testimonies_screen/widgets/testimony_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

String _text =
    'Consequat magna fugiat dolor sit aliquip cupidatat sunt cillum proident. Ex adipisicing minim irure mollit. Anim minim deserunt irure est nostrud irure ullamco sit laborum id nostrud exercitation velit. Pariatur pariatur voluptate veniam ex minim ullamco. Tempor ex quis voluptate dolor ut aliqua quis ea minim. Ea mollit Lorem enim enim velit qui ea labore aute. Do aliqua ullamco duis deserunt deserunt excepteur tempor tempor eu commodo.';

class TestimoniesView extends StatefulWidget {
  const TestimoniesView({Key? key}) : super(key: key);

  @override
  State<TestimoniesView> createState() => _TestimoniesViewState();
}

class _TestimoniesViewState extends State<TestimoniesView> {
  int random = Random().nextInt(2) + 1;
  int likes = 255;
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
            padding: const EdgeInsets.only(bottom: 20),
            child: TestimonyCard(
              editable: false,
              title: 'Announcements Lorem ipsum',
              testimony: _text,
              likes: likes,
              cardColor: Constants.colors1[random],
              textColor: kBlueDark,
              timeAgo: '6 Hours Ago',
              onTapLike: () {
                setState(() {
                  likes++;
                });
              },
              onTapCard: () {
                print('cliked card');
              },
            ),
          );
        },
      ),
    );
  }
}
