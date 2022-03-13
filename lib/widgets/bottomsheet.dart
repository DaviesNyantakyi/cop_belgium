import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../utilities/constant.dart';

Future<dynamic> showMyBottomSheet({
  required BuildContext context,
  Widget? child,
  bool? isDismissible = true,
  bool isScrollControlled = true,
  bool enableDrag = true,
  double? height = kBottomSheetHeight,
  double? fullScreenHeight = 0.9,
  EdgeInsetsGeometry padding = const EdgeInsets.all(kBodyPadding),
}) async {
  return await showModalBottomSheet<dynamic>(
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
          padding: padding,
          child: FractionallySizedBox(
            heightFactor: fullScreenHeight,
            child: child,
          ),
        ),
      );
    },
  );
}

void loadMdFile({required BuildContext context, required String mdFile}) {
  showMyBottomSheet(
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
