import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/screens/fasting_screen/fasting_screen.dart';
import 'package:cop_belgium/screens/fasting_screen/widgets/fasting_card.dart';
import 'package:cop_belgium/utilities/constant.dart';

import 'package:cop_belgium/utilities/remove_scroll_glow.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateFastingScreens extends StatefulWidget {
  static String createFastingScreens = 'createFastingScreens';
  const CreateFastingScreens({Key? key}) : super(key: key);

  @override
  State<CreateFastingScreens> createState() => _CreateFastingScreensState();
}

class _CreateFastingScreensState extends State<CreateFastingScreens> {
  List<FastingInfo> fastingPresets = [
    FastingInfo(
      type: 'Custom',
      duration: const Duration(hours: 13),
      dateStart: DateTime.now(),
    ),
    FastingInfo(
      type: 'Custom',
      duration: const Duration(hours: 16),
      dateStart: DateTime.now(),
    ),
    FastingInfo(
      type: 'Custom',
      duration: const Duration(hours: 18),
      dateStart: DateTime.now(),
    ),
    FastingInfo(
      type: 'Custom',
      duration: const Duration(hours: 20),
      dateStart: DateTime.now(),
    ),
    FastingInfo(
      type: 'Custom',
      duration: const Duration(hours: 36),
      dateStart: DateTime.now(),
    ),
  ];

  //fasting card
  //fasting info

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: kBodyPadding),
          child: Text(
            'Choose Fast',
            style: kSFHeadLine2,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: kBodyPadding)
                    .copyWith(top: kBodyPadding),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                ),
                itemCount: fastingPresets.length + 1, //  +1 for the custom card
                itemBuilder: (BuildContext ctx, index) {
                  if (index != 5) {
                    return PresetFastingCard(
                      typeFast: 'Preset',
                      duration: fastingPresets[index].duration!.inHours,
                      backgroundColor: kLightColors[index],
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return FastingScreen(
                              fastingInfo: fastingPresets[index],
                            );
                          },
                        ));
                      },
                    );
                  } else {
                    return CustomFastingCard(
                      typeFast: 'Custom',
                      onPressed: () {
                        showMyFastingBottomSheet(
                          context: context,
                          child: const FastingPicker(),
                        );
                      },
                      fontColor: kBlueDark,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildBtn({
  required String btText,
  VoidCallback? onPressed,
  Color? buttonColor = kYellowLight,
  Color? textColor = Colors.white,
}) {
  return SizedBox(
    width: double.infinity,
    height: 48,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(kButtonRadius),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        btText,
        style: kSFBodyBold.copyWith(color: textColor),
      ),
    ),
  );
}

class FastingPicker extends StatefulWidget {
  const FastingPicker({Key? key}) : super(key: key);

  @override
  _FastingPickerState createState() => _FastingPickerState();
}

class _FastingPickerState extends State<FastingPicker> {
  Duration? duration = const Duration(days: 1, hours: 0);
  DateTime startDate = DateTime.now();

  // chosen custom fast values passed in in the duration oject
  int days = 1;
  int hours = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                ScrollConfiguration(
                  behavior: MyBehavior(), // removes listview glow
                  child: NumberPicker(
                    selectedTextStyle: kSFHeadLine2,
                    textStyle: kSFHeadLine2,
                    value: days,
                    minValue: 1,
                    maxValue: 7,
                    onChanged: (value) {
                      setState(() {
                        days = value;
                        duration = Duration(days: days, hours: hours);
                      });
                    },
                  ),
                ),
                const Text(
                  'Days',
                  style: kSFHeadLine2,
                ),
              ],
            ),
            Row(
              children: [
                ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: NumberPicker(
                    selectedTextStyle: kSFHeadLine2,
                    textStyle: kSFHeadLine2,
                    value: hours,
                    minValue: 0,
                    maxValue: 23,
                    onChanged: (value) {
                      setState(() {
                        hours = value;
                        duration = Duration(days: days, hours: hours);
                      });
                    },
                  ),
                ),
                const Text(
                  'Hours',
                  style: kSFHeadLine2,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
          child: _buildBtn(
            btText: 'Start Fast',
            onPressed: () async {
              Navigator.pop(context);
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return FastingScreen(
                    fastingInfo: FastingInfo(
                      duration: duration,
                      dateStart: startDate,
                      type: 'Custom',
                    ),
                  );
                }),
              );
            },
            buttonColor: kGreen,
          ),
        ),
      ],
    );
  }
}
