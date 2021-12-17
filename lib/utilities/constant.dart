import 'package:flutter/material.dart';

//Fonts
const String _sfDisplayFont = 'SFDisplay';

const kSFHeadLine1 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 36,
  color: kDarkBlue,
  fontFamily: _sfDisplayFont,
);
const kSFHeadLine2 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 24,
  color: kDarkBlue,
  fontFamily: _sfDisplayFont,
);

const kSFBody = TextStyle(
  fontWeight: FontWeight.w400,
  color: kDarkBlue,
  fontSize: 16,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);
const kSFBodyBold = TextStyle(
  fontWeight: FontWeight.w700,
  color: kDarkBlue,
  fontSize: 16,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);
const kSFCaptionNormal = TextStyle(
  fontWeight: FontWeight.w400,
  color: kDarkBlue,
  fontSize: 18,
  fontFamily: _sfDisplayFont,
);
const kSFCaptionBold = TextStyle(
  fontWeight: FontWeight.w700,
  color: kDarkBlue,
  fontSize: 18,
  fontFamily: _sfDisplayFont,
);
const kSFSubtitle1 = TextStyle(
  fontWeight: FontWeight.w600,
  color: kDarkBlue,
  fontSize: 16,
  fontFamily: _sfDisplayFont,
);

const kSFSubtitle2 = TextStyle(
  fontWeight: FontWeight.w400,
  color: kDarkBlue,
  fontSize: 14,
  fontFamily: _sfDisplayFont,
);
const kSFSubtitle2Bold = TextStyle(
  fontWeight: FontWeight.w700,
  color: kDarkBlue,
  fontSize: 14,
  fontFamily: _sfDisplayFont,
);

//Colors

//Blues
const Color kBlue = Color(0xFF4F6BFE);
const Color kDarkBlue = Color(0xFF1E2B5F);
const Color kBlueLight1 = Color(0xFFF2F6FD);
const Color kBlueLight = Color(0xFFDCDDF1);

//Reds
const Color kRed = Color(0xFFFF5918);
const Color kRedLight = Color(0xFFF1DCE0);
const Color kDarkRed = Color(0xFFA07777);

//Yellow
const Color kYellow = Color(0xFFFEAE4F);
const Color kYellowLight = Color(0xFFF1E9DC);

//Green
const Color kGreen = Color(0xFF1EB191);
const Color kGreenLight = Color(0xFFDCF1F0);

//Indigo
const Color kIndigo = Color(0xFFC93F8D);
const Color kIndigoLight1 = Color(0xFFF1DCED);
const Color kIndigoLight2 = Color(0xFFF1EFF7);

const List<Color> kDefaultColors = [
  kBlue,
  kRed,
  kYellow,
  kGreen,
  kIndigo,
];
const List<Color> kLightColors = [
  kBlueLight,
  kRedLight,
  kYellowLight,
  kGreenLight,
  kIndigoLight1,
];

//Other

const double kAppbarPadding = 20.0;
const double kBodyPadding = 15.0;
const double kBodyBottomPadding = 40.0;
const double kBottomSheetHeight = 400;

// spacing between each textfield
const double kTextFieldSpacing = 12;
const double kButtonRadius = 10;
// spacing between button and textfield
const double kButtonSpacing = 25;

//Disables the textButton default padding
ButtonStyle kTextButtonStyle = TextButton.styleFrom(
  minimumSize: Size.zero,
  padding: EdgeInsets.zero,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
