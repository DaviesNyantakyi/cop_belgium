import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/screens/fasting_screen/fasting_timer_screen.dart';
import 'package:cop_belgium/screens/fasting_screen/widgets/fasting_card.dart';
import 'package:cop_belgium/utilities/constant.dart';

import 'package:cop_belgium/utilities/remove_scroll_glow.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class FastingScreen extends StatefulWidget {
  static String fastingScreen = 'fastingScreen';
  const FastingScreen({Key? key}) : super(key: key);

  @override
  State<FastingScreen> createState() => _FastingScreenState();
}

class _FastingScreenState extends State<FastingScreen> {
  User? auth = FirebaseAuth.instance.currentUser;
  int peopleFasting = 0;

  List<FastingInfo> fastingPresets = [
    //When the user presses the card the startDate and endDate are set.
    // If set in object the time can differ from the acctual time the user presses the button.
    FastingInfo(
      type: 'Custom',
      duration: const Duration(seconds: 14),
    ),
    FastingInfo(
      type: 'Custom',
      duration: const Duration(hours: 16),
    ),
    FastingInfo(
      type: 'Custom',
      duration: const Duration(hours: 18),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding).copyWith(top: 20),
          child: Column(
            children: [
              _buildHeader(people: peopleFasting),
              const SizedBox(height: 30),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),

                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                ),
                itemCount: fastingPresets.length + 1, //  +1 for the custom card
                itemBuilder: (BuildContext ctx, index) {
                  if (index != 3) {
                    return PresetFastingCard(
                      backgroundGradient: kGradients[index],
                      duration: fastingPresets[index].duration.inHours,
                      onPressed: () {
                        //when the user selects card the start date and goal are calculated.
                        _calculateStartGoalDate(index: index);

                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context) {
                            return FastingTimerScreen(
                              fastingInfo: fastingPresets[index],
                            );
                          },
                        ));
                      },
                    );
                  } else {
                    return CustomFastingCard(
                      onPressed: () {
                        showSmallBottomSheet(
                          context: context,
                          child: const FastingPicker(),
                        );
                      },
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

  Widget _buildHeader({required int people}) {
    return Column(
      children: [
        const Text(
          'Create a fast',
          style: kSFHeadLine2,
        ),
        Text(
          '$people People are fasting right now',
          style: kSFBody,
        ),
      ],
    );
  }

  void _calculateStartGoalDate({required int index}) {
    //when the user selects a card the startDate and goalDate are calculated.
    //before going to the fasting screen.
    setState(() {
      final currentDate = DateTime.now();
      fastingPresets[index].startDate = currentDate;
      fastingPresets[index].goalDate = currentDate.add(
        Duration(
          seconds: fastingPresets[index].duration.inSeconds,
        ),
      );
    });
  }
}

dynamic _buildAppbar({required BuildContext context}) {
  return AppBar(
    title: const Text(
      'Fasting',
      style: kSFHeadLine3,
    ),
    leading: kBackButton(context: context),
  );
}

Widget _buildBtn({
  required String btText,
  VoidCallback? onPressed,
  Color? buttonColor = kBlue,
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
  Duration? chosenDuration = const Duration(days: 1, hours: 0);
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
                  //ScrollConfiguration removes listview glow
                  behavior: MyBehavior(),
                  child: NumberPicker(
                    selectedTextStyle: kSFHeadLine2,
                    textStyle: kSFHeadLine2,
                    value: days,
                    minValue: 1,
                    maxValue: 7,
                    onChanged: (value) {
                      setState(() {
                        days = value;
                        chosenDuration = Duration(days: days, hours: hours);
                      });
                    },
                  ),
                ),
                const Text('Days', style: kSFHeadLine2),
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
                        chosenDuration = Duration(days: days, hours: hours);
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
              final currentDate = DateTime.now();

              Navigator.pop(context);
              await Navigator.push(context, CupertinoPageRoute(
                builder: (context) {
                  return FastingTimerScreen(
                    fastingInfo: FastingInfo(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      type: 'Custom',
                      duration: chosenDuration!,
                      startDate: currentDate,
                      goalDate: currentDate.add(chosenDuration!),
                    ),
                  );
                },
              ));
            },
            buttonColor: kGreen,
          ),
        ),
      ],
    );
  }
}
