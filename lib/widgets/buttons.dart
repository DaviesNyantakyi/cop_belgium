import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class Buttons {
  static Widget buildBtn({
    required BuildContext context,
    required String btnText,
    Color color = kYellow,
    Color fontColor = kBlueDark,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          btnText,
          style: kSFBodyBold.copyWith(color: fontColor),
        ),
      ),
    );
  }
}
