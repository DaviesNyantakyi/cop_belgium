import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

Future<String?> showMyDialog({
  required BuildContext context,
  Widget? title,
  Widget? content,
  List<Widget>? actions,
  bool barrierDismissible = true,
}) async {
  return await showDialog<String?>(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
      ),
      title: title,
      content: content,
      actions: actions,
    ),
  );
}
