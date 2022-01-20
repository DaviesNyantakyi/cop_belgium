import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class Buttons {
  static Widget buildBtn({
    required BuildContext context,
    required String btnText,
    Color color = kYellowDark,
    Color fontColor = kBlueDark,
    VoidCallback? onPressed,
    double? width,
    double? height = kButtonHeight,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(2),
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

  static Widget buildSocialBtn({
    required BuildContext context,
    Color color = kYellow,
    Color fontColor = kBlueDark,
    VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
  }) {
    return SizedBox(
      width: double.infinity,
      height: kButtonHeight,
      child: ElevatedButton.icon(
        icon: icon,
        label: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Center(
            child: label,
          ),
        ),
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
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
      ),
    );
  }
}
