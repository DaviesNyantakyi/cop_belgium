import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/widgets/testimony_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';

//TODO: fix: if a testimony field is null in firbase then have an error
class TestimoniesTabView extends StatefulWidget {
  const TestimoniesTabView({Key? key}) : super(key: key);

  @override
  State<TestimoniesTabView> createState() => _TestimoniesTabViewState();
}

class _TestimoniesTabViewState extends State<TestimoniesTabView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kBodyPadding),
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: kCardSpacing),
        itemCount: 10,
        itemBuilder: (context, index) {
          return TestimonyCard(
            testimonyInfo: TestimonyInfo(
              title: '',
              description: '',
              date: DateTime.now(),
              userId: '',
            ),
            onPressedCard: () {
              _showBottomSheet(
                context: context,
                title: '',
                testimony: '',
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
