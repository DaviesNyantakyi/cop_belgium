import 'package:flutter/material.dart';

//Fonts
const String _sfDisplayFont = 'SFDisplay';

const kSFOverline = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlueDark,
  fontSize: 12,
  fontFamily: _sfDisplayFont,
);
const kSFOverlineBold = TextStyle(
  fontWeight: FontWeight.w700,
  color: kBlueDark,
  fontSize: 12,
  fontFamily: _sfDisplayFont,
);

const kSFCaption = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlueDark,
  fontSize: 14,
  fontFamily: _sfDisplayFont,
);
const kSFCaptionBold = TextStyle(
  fontWeight: FontWeight.w700,
  color: kBlueDark,
  fontSize: 14,
  fontFamily: _sfDisplayFont,
);

const kSFBody = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlueDark,
  fontSize: 16,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);
const kSFBodyBold = TextStyle(
  fontWeight: FontWeight.w700,
  color: kBlueDark,
  fontSize: 16,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);

const kSFHeadLine2 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 24,
  color: kBlueDark,
  fontFamily: _sfDisplayFont,
);
const kSFHeadLine1 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 36,
  color: kBlueDark,
  fontFamily: _sfDisplayFont,
);

//Colors

//Blues
const Color kBlue = Color(0xFF0009EB);
const Color kBlueDark = Color(0xFF1E2B5F);

//Reds
const Color kRed = Color(0xFFFE4F4F);

//Yellow
const Color kYellow = Color(0xFFFDD835);
const Color kYellowLight = Color(0xFFFFBA3C);

//Green
const Color kGreen = Color(0xFF00B488);

//Grey
const Color kGrey = Color(0xFFF8F9FA);

//Blijven
const double kButtonSize = 45;
const double kButtonRadius = 5;
const double kTextFieldSpacing = 12;
const double kButtonSpacing = 25;
//Weg

const double kAppbarPadding = 20.0;
const double kBodyPadding = 15.0;

const double kBodyBottomPadding = 40.0;
const double kBottomSheetHeight = 470;

// spacing between button and textfield

//Disables the textButton default padding
ButtonStyle kTextButtonStyle = TextButton.styleFrom(
  minimumSize: Size.zero,
  padding: EdgeInsets.zero,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
