import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class ServiceTimeTile extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const ServiceTimeTile(
      {Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: kGreyLight,
        borderRadius: const BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(kCardContentPadding),
          child: child,
        ),
      ),
    );
  }
}
