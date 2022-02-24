import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class BuildCopLogo extends StatelessWidget {
  const BuildCopLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logos/cop_logo.jpg',
      width: kCopLogoSize,
    );
  }
}
