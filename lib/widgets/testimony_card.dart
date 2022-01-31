import 'package:cop_belgium/models/testimony_model.dart';

import 'package:cop_belgium/utilities/constant.dart';

import 'package:flutter/material.dart';

class TestimonyCard extends StatefulWidget {
  final VoidCallback? onPressedCard;
  final VoidCallback? onPressedEdit;
  final TestimonyInfo testimonyInfo;

  const TestimonyCard({
    Key? key,
    this.onPressedCard,
    this.onPressedEdit,
    required this.testimonyInfo,
  }) : super(key: key);

  @override
  State<TestimonyCard> createState() => _TestimonyCardState();
}

class _TestimonyCardState extends State<TestimonyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          kBoxShadow,
        ],
      ),
      child: TextButton(
        onPressed: widget.onPressedCard,
        style: kTextButtonStyle,
        child: Padding(
          padding: const EdgeInsets.all(kCardContentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: const [],
          ),
        ),
      ),
    );
  }
}
