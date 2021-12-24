import 'package:flutter/material.dart';

//Fonts
const String _sfDisplayFont = 'SFDisplay';

const kSFHeadLine1 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 36,
  color: kBlueDark,
  fontFamily: _sfDisplayFont,
);
const kSFHeadLine2 = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 24,
  color: kBlueDark,
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
const kSFCaptionNormal = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlueDark,
  fontSize: 18,
  fontFamily: _sfDisplayFont,
);
const kSFCaptionBold = TextStyle(
  fontWeight: FontWeight.w700,
  color: kBlueDark,
  fontSize: 18,
  fontFamily: _sfDisplayFont,
);
const kSFSubtitle1 = TextStyle(
  fontWeight: FontWeight.w600,
  color: kBlueDark,
  fontSize: 16,
  fontFamily: _sfDisplayFont,
);

const kSFSubtitle2 = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlueDark,
  fontSize: 14,
  fontFamily: _sfDisplayFont,
);
const kSFSubtitle2Bold = TextStyle(
  fontWeight: FontWeight.w700,
  color: kBlueDark,
  fontSize: 14,
  fontFamily: _sfDisplayFont,
);

//Colors

//Blues
const Color kBlue = Color(0xFF3A5AFF);
const Color kBlueDark = Color(0xFF1E2B5F);
const Color kBlueLight = Color(0xFF7292DB);
const Color kBlueLight2 = Color(0xFFDCDDF1);

//Reds
const Color kRed = Color(0xFFFE4F4F);
const Color kRedDark = Color(0xFF5F2E1E);
const Color kRedLight = Color(0xFFE18473);
const Color kRedLight2 = Color(0xFFF1DCE0);

//Yellow
const Color kYellow = Color(0xFFFEAE4F);
const Color kYellowLight = Color(0xFFE8AD6B);
const Color kYellowLight2 = Color(0xFFF1E9DC);
const Color kYellowDark = Color(0xFF8D8F2A);

//Green
const Color kGreen = Color(0xFF2C8D78);
const Color kGreenLight = Color(0xFF428C8F);
const Color kGreenLight2 = Color(0xFFDCF1F0);
const Color kGreenDark = Color(0xFF1E5F21);

//Indigo
const Color kIndigo = Color(0xFF9C4FFE);
const Color kIndigoLight = Color(0xFF66538A);
const Color kIndigoLight2 = Color(0xFFF1DCED);

//Grey
const Color kGrey = Color(0xFF5F656D);
const Color kGreyLight = Color(0xFFF8F8F8);

const List<Color> kDefaultColors = [
  kBlue,
  kRed,
  kYellow,
  kGreen,
  kIndigo,
];
List<Color> kLightColors = [
  kBlueLight,
  kRedLight,
  kYellowLight,
  kGreenLight,
  kIndigoLight,
];
List<Color> kLightColors2 = [
  kBlueLight2,
  kRedLight2,
  kYellowLight2,
  kIndigoLight2,
];

//Other

const double kAppbarPadding = 20.0;
const double kBodyPadding = 15.0;

const double kBodyBottomPadding = 40.0;
const double kBottomSheetHeight = 470;

// spacing between each textfield
const double kTextFieldSpacing = 12;
const double kButtonRadius = 10;
// spacing between button and textfield
const double kButtonSpacing = 25;
const double kButtonSize = 45;

//Disables the textButton default padding
ButtonStyle kTextButtonStyle = TextButton.styleFrom(
  minimumSize: Size.zero,
  padding: EdgeInsets.zero,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
