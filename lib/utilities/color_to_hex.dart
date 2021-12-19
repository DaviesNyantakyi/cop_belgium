import 'package:flutter/material.dart';

String colorToHex({required Color? color}) {
  String stringColor = color.toString();
  List x = stringColor.split('Color')[1].split('(')[1].split(')');

  String hexColor = x[0].toString();
  return hexColor;
}
