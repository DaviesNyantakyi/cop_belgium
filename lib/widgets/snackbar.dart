import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

dynamic kshowSnackbar({
  required BuildContext context,
  required Widget child,
  Color backgroundColor = kGreenLight,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
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
