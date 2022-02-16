import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Future<void> showBottomSheet1({
  required BuildContext context,
  Widget? child,
  bool? isDismissible = true,
  bool isScrollControlled = true,
  bool enableDrag = true,
  double? height = kBottomSheetHeight,
}) async {
  return await showModalBottomSheet<void>(
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible!,
    enableDrag: enableDrag,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        height: height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kButtonRadius),
            topRight: Radius.circular(kButtonRadius),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: child,
        ),
      );
    },
  );
}

Future<void> showBottomSheet2({
  required BuildContext context,
  Widget? child,
  double? height = 300,
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
        height: height,
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

void loadMdFile({required BuildContext context, required String mdFile}) {
  showBottomSheet1(
    context: context,
    child: SingleChildScrollView(
      child: FutureBuilder(
        future: rootBundle.loadString(mdFile),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return MarkdownBody(
              styleSheet: MarkdownStyleSheet(
                p: kSFBody,
              ),
              data: snapshot.data!,
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ),
  );
}
