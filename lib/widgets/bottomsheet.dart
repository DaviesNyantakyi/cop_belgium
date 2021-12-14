import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

Future<void> showMyBottomSheet(
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
        decoration: const BoxDecoration(
          color: kBlueLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.60,
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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.40,
        child: child,
      );
    },
  );
}
