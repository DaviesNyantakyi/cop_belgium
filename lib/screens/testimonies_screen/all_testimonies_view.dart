import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';

String _text =
    'Consequat magna fugiat dolor sit aliquip cupidatat sunt cillum proident. Ex adipisicing minim irure mollit. Anim minim deserunt irure est nostrud irure ullamco sit laborum id nostrud exercitation velit. Pariatur pariatur voluptate veniam ex minim ullamco. Tempor ex quis voluptate dolor ut aliqua quis ea minim. Ea mollit Lorem enim enim velit qui ea labore aute. Do aliqua ullamco duis deserunt deserunt excepteur tempor tempor eu commodo.';

String _title = 'Announcements Lorem ipsum';

class TestimoniesView extends StatefulWidget {
  const TestimoniesView({Key? key}) : super(key: key);

  @override
  State<TestimoniesView> createState() => _TestimoniesViewState();
}

class _TestimoniesViewState extends State<TestimoniesView> {
  int likes = 255;
  Color cardColor = kBlueLight;
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
              title: _title,
              testimony: _text,
              likes: likes,
              cardColor: cardColor,
              timeAgo: '6 Hours Ago',
              onPressedLike: () {
                setState(() {
                  likes++;
                });
              },
              onPressedCard: () {
                _showBottomSheet(
                  context: context,
                  title: _title,
                  testimony: _text,
                );
              },
            ),
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
            _text,
            style: kSFBody,
          ),
        ),
      ],
    ),
  );
}
