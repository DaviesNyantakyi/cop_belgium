import 'package:flutter/material.dart';

//Fonts

const String _sfDisplayFont = 'SFDisplay';

const kSFCaption = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlack,
  fontSize: 12,
  fontFamily: _sfDisplayFont,
);
const kSFCaptionBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: kBlack,
  fontSize: 12,
  fontFamily: _sfDisplayFont,
);

// for normal text eg when reading
const kSFBody = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlack,
  fontSize: 16,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);
const kSFBodyBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: kBlack,
  fontSize: 16,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);
const kSFBody2 = TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlack,
  fontSize: 14,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);
const kSFBody2Bold = TextStyle(
  fontWeight: FontWeight.bold,
  color: kBlack,
  fontSize: 14,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);

const kSFBtnStyleBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: kBlack,
  fontSize: 14,
  height: 1.4,
  fontFamily: _sfDisplayFont,
);

// headlines of articals
const kSFHeadLine1 = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 34,
  color: kBlack,
  fontFamily: _sfDisplayFont,
);
const kSFHeadLine2 = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 24,
  color: kBlack,
  fontFamily: _sfDisplayFont,
);

const kSFHeadLine3 = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
  color: kBlack,
  fontFamily: _sfDisplayFont,
);

//Colors

//White
const Color kWhite = Color(0xFFFFFFFF);

//Black
const Color kBlack = Color(0xFF000000);
const kDisabledColor = Colors.black45;

//Blues
const Color kBlue = Color(0xFF4F6BFE);

const Color kBlueLight = Color(0xFFF6FBFF);

const Color kBlueDark2 = Color(0xFF384859);

//Reds
const Color kRed = Color(0xFFFE4F4F);

//Green
const Color kGreen = Color(0xFF00B488);

//Grey
const Color kGrey = Color(0xFFF8F9FA);
Color kGreyLight = Colors.grey.shade200;

//Gradients
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
  colors: [
    kBlueDark2,
    kBlueDark2,
  ],
);

List<LinearGradient> kGradients = [
  kRedGradient,
  kGreenGradient,
  kPurpleGradient,
  kBlueDarkGradient,
];

const double kAppbarElevation = 1;

const double kRadius = 10;
const double kButtonRadius = 5;

const double kCardContentPadding = 16;
const double kBodyPadding = 16.0;

const double kButtonHeight = 50;
const double kButtonWidth = 100;

const double kCopLogoSize = 120;

const double kContentSpacing8 = 8;
const double kContentSpacing12 = 12;
const double kContentSpacing16 = 16;
const double kContentSpacing20 = 20;
const double kContentSpacing32 = 32;

const double kIconSize = 24;
const double kDividerThickness = 1;

Duration kPagViewDuration = const Duration(milliseconds: 800);
Curve kPagViewCurve = Curves.easeOutExpo;

BoxShadow kBoxShadow = BoxShadow(
  offset: const Offset(0, 4),
  blurRadius: 10,
  color: Colors.black.withOpacity(0.2),
);

const kCircularProgressIndicator = CircularProgressIndicator(
  strokeWidth: 5,
  color: kBlack,
);

const kTextFieldOutlined = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

DateTime kMaxDate = DateTime(2050, 12, 31);
DateTime kMinDate = DateTime(1900, 01, 31);

const double kBottomSheetHeight = 470;
const double kPickerBottomSheetHeight = 170;

//Disables the textButton default padding
ButtonStyle kTextButtonStyle = TextButton.styleFrom(
  minimumSize: Size.zero,
  padding: EdgeInsets.zero,
  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
dynamic kBackButton({required BuildContext context}) {
  return TextButton(
    style: kTextButtonStyle,
    child: const Icon(
      Icons.chevron_left,
      color: kBlack,
      size: 40,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
