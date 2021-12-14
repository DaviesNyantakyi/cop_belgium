import 'package:flutter/material.dart';

enum Locations { turnhout }
//Blues
const Color kBlue = Color(0xFF4F6BFE);
const Color kBlueDark = Color(0xFF1E2B5F);
const Color kBlueLight = Color(0xFFDCDDF1);

//Reds
// heading text
const Color kRed = Color(0xFFFF5918);
const Color kRedLight = Color(0xFFF1DCE0);
const Color kRedDark = Color(0xFFA07777);

//Yellow
const Color kYellow = Color(0xFFFEAE4F);
const Color kYellowLight = Color(0xFFF1E9DC); // cards background

//Green
const Color kGreen = Color(0xFF1EB191); // heading text
const Color kGreen1Light = Color(0xFFDCF1F0); // cards background

//Indigo
const Color kIndigo = Color(0xFFC93F8D);
const Color kIndigoLight1 = Color(0xFFF1DCED);
const Color kIndigoLight2 = Color(0xFFF1EFF7);

const double kAppbarPadding = 20.0;
const double kBodyPadding = 15.0;
const double kBodyBottomPadding = 40.0;

ButtonStyle kTextButtonStyle = TextButton.styleFrom(
  minimumSize: Size.zero,
  padding: EdgeInsets.zero,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);

const double kTextFieldSpacing = 24;
const double kButtonRadius = 10;

//Color picker colors
class Constants {
  //Colors for the edit testimonies_sreen.
  //More colors kan be added by adding a new list.
  //If more colors are added the SmoothPageIndicator count in color_picker.dart must be changed.
  static const List<Color> colors1 = [
    kBlueLight,
    kRedLight,
    kGreen1Light,
    kYellowLight,
  ];

  /*
   static const List<Color> colors1 = [
    kBlueLight,
    kRedLight,
    kGreen1Light,
    kYellowLight,
  ];*/
}
