import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

dynamic kshowSnackbar({
  required BuildContext context,
  required String errorType,
  required String text,
}) {
  Color? backgroundColor;
  Color textColor;
  switch (errorType) {
    case 'error':
      backgroundColor = kRed;
      textColor = Colors.white;
      break;
    case 'succes':
      backgroundColor = kGreen;
      textColor = Colors.white;
      break;

    default:
      backgroundColor = kGrey;
      textColor = kBlueDark;
      break;
  }
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(kBodyPadding),
      elevation: 7,
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 5),
      content: Text(
        text,
        style: kSFBodyBold.copyWith(color: textColor),
      ),
    ),
  );
}
