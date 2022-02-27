import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

Widget buildDivderText() {
  double dividerWidth = 100;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: dividerWidth,
        child: Divider(color: kBlack.withOpacity(0.5)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          'OR',
          style: kSFBodyBold.copyWith(color: kBlack.withOpacity(0.5)),
        ),
      ),
      SizedBox(
        width: dividerWidth,
        child: Divider(color: kBlack.withOpacity(0.5)),
      ),
    ],
  );
}
