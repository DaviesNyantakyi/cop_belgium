import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

Future<void> showMyBottomSheet({
  required BuildContext context,
  Widget? child,
}) async {
  return await showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        height: kBottomSheetHeight,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kButtonRadius),
            topRight: Radius.circular(kButtonRadius),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: child,
          ),
        ),
      );
    },
  );
}

Future<void> showMyFastingBottomSheet(
    {required BuildContext context, Widget? child}) async {
  return await showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: child,
      );
    },
  );
}
