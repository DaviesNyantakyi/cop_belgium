import 'package:flutter/material.dart';

//Fonts
const String _sfDisplayFont = 'SFDisplay';

//
const kSFCaption = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlueDark,
  fontSize: 12,
  fontFamily: _sfDisplayFont,
);
const kSFCaptionBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: kBlueDark,
  fontSize: 12,
  fontFamily: _sfDisplayFont,
);

// for normal text eg when reading
const kSFBody = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlueDark,
  fontSize: 16,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);
const kSFBodyBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: kBlueDark,
  fontSize: 16,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);
const kSFBody2 = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlueDark,
  fontSize: 14,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);
const kSFBody2Bold = TextStyle(
  fontWeight: FontWeight.bold,
  color: kBlueDark,
  fontSize: 14,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);

TextStyle kSFTextFieldStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: kBlueDark.withOpacity(0.5),
  fontSize: 16,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);

// used for buttons
const kSFBtnStyleNormal = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlueDark,
  fontSize: 14,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);

const kSFBtnStyleBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: kBlueDark,
  fontSize: 14,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);

// headlines of articals
const kSFHeadLine1 = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 24,
  color: kBlueDark,
  fontFamily: _sfDisplayFont,
);

const kSFHeadLine2 = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kBlueDark,
  fontFamily: _sfDisplayFont,
);

//Colors

//Blues
const Color kBlue = Color(0xFF0009EB);
const Color kBlueLight = Color(0xFFF1F6F9);
const Color kBlueDark = Color(0xFF1E2B5F);
const Color kBlueDark2 = Color(0xFF384859);

//Reds
const Color kRed = Color(0xFFFE4F4F);

//Yellow
const Color kYellow = Color(0xFFFDD835);
const Color kYellowDark = Color(0xFFFFBA3C);

//Green
const Color kGreen = Color(0xFF00B488);

//Grey
const Color kGrey = Color(0xFFF8F9FA);

const LinearGradient kRedGradient = LinearGradient(
  colors: [
    Color(0xFFF78CA0),
    Color(0xFFF9748F),
    Color(0xFFFD868C),
  ],
);
const LinearGradient kGreenGradient = LinearGradient(
  colors: [
    Color(0xFF58926C),
    Color(0xFF659F8A),
  ],
);
const LinearGradient kPurpleGradient = LinearGradient(
  colors: [
    Color(0xFF585E92),
    Color(0xFF65689F),
  ],
);
const LinearGradient kBlueDarkGradient = LinearGradient(
  colors: [kBlueDark2],
);

List<LinearGradient> kGradients = [
  kRedGradient,
  kGreenGradient,
  kPurpleGradient,
  kBlueDarkGradient,
];
//Stay
const double kButtonHeight = 45;
const double kButtonRadius = 5;
const double kTextFieldSpacing = 12;
const double kButtonSpacing = 25;
const double kAppbarPadding = 20.0;
const double kBodyPadding = 10.0;
const double kIconSize = 24;
const double kCardSpacing = 10;

const double kCardContentPadding = 16;

BoxShadow kBoxShadow = BoxShadow(
  offset: const Offset(0, 4),
  blurRadius: 10,
  color: Colors.black.withOpacity(0.2),
);

const kCircularProgress = CircularProgressIndicator(
  strokeWidth: 5,
);

const double kBottomSheetHeight = 470;
const double kPickerBottomSheetHeight = 170;

//Disables the textButton default padding
ButtonStyle kTextButtonStyle = TextButton.styleFrom(
  minimumSize: Size.zero,
  padding: EdgeInsets.zero,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
