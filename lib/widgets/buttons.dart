import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class Buttons {
  static Widget buildButton({
    required BuildContext context,
    required String btnText,
    Color color = kBlue,
    Color fontColor = kWhite,
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

  static Widget buildSocialButton({
    required BuildContext context,
    Color color = Colors.transparent,
    Color fontColor = kBlack,
    VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
  }) {
    return SizedBox(
      width: double.infinity,
      height: kButtonHeight,
      child: OutlinedButton.icon(
        icon: icon,
        label: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Center(
            child: label,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          side: MaterialStateProperty.all(const BorderSide()),
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

  static Widget buildOutlinedButton({
    required BuildContext context,
    Color color = Colors.transparent,
    Color fontColor = kBlack,
    VoidCallback? onPressed,
    required Widget child,
    double? width,
    double? height = kButtonHeight,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          side: MaterialStateProperty.all(const BorderSide()),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
