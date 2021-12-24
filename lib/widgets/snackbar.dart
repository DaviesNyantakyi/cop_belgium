import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

dynamic kshowSnackbar({
  required BuildContext context,
  required String type,
  required Widget child,
}) {
  Color? backgroundColor;
  switch (type) {
    case 'error':
      backgroundColor = kRedLight2;
      break;
    case 'succes':
      backgroundColor = kGreyLight;
      break;

    default:
      backgroundColor = kGreyLight;
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
      content: child,
    ),
  );
}
