import 'package:flutter/material.dart';

class MyBehavior extends ScrollBehavior {
  // this removes the glow created at the end of the list
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
