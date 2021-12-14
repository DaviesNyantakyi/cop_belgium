import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';

class FastingScreens extends StatelessWidget {
  static String fastingScreens = 'fastingScreens';
  const FastingScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 30),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Choose Fast',
                  style: kSFHeadLine2,
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 25),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                children: [
                  PresetFastingCard(
                    duration: 13,
                    backgroundColor: kGreen1Light,
                    typeFast: 'Preset',
                    onPressed: () {},
                    fontColor: kGreen,
                  ),
                  PresetFastingCard(
                    duration: 16,
                    backgroundColor: kRedLight,
                    typeFast: 'Preset',
                    onPressed: () {},
                    fontColor: kRedDark,
                  ),
                  PresetFastingCard(
                    duration: 18,
                    backgroundColor: kIndigoLight1,
                    typeFast: 'Preset',
                    onPressed: () {},
                    fontColor: kIndigo,
                  ),
                  CustomFastingCard(
                    typeFast: 'Custom',
                    onPressed: () {
                      showMyBottomSheet(
                        context: context,
                        child: const Text(
                          'choose fast',
                        ),
                      );
                    },
                    backgroundColor: kIndigoLight2,
                    fontColor: kBlueDark,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* PresetFastingCard(
                duration: 13,
                backgroundColor: kGreen1Light,
                typeFast: 'Preset',
                onPressed: () {},
                fontColor: kGreen,
              ),
              const SizedBox(height: 30),
              CustomFastingCard(
                typeFast: 'Custom',
                onPressed: () {},
                backgroundColor: kRedLight,
                fontColor: kRedDark,
              )*/
// fasting card
// type of fast String
// hours
class PresetFastingCard extends StatelessWidget {
  final String typeFast;
  final int duration;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color fontColor;
  const PresetFastingCard({
    Key? key,
    required this.typeFast,
    required this.duration,
    required this.onPressed,
    required this.backgroundColor,
    this.fontColor = kBlueDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int day = 24;
    return Container(
      width: 180,
      height: 169,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: kTextButtonStyle,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 21,
            top: 28,
            right: 26,
            bottom: 22,
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$duration:${day - duration} TRF',
                  style: kSFBody.copyWith(color: fontColor),
                ),
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  Text(
                    '$duration',
                    style: kSFHeadLine1.copyWith(color: fontColor),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'Hours',
                    style: kSFCaption.copyWith(
                      fontWeight: FontWeight.w400,
                      color: fontColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFastingCard extends StatelessWidget {
  final String typeFast;

  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color fontColor;
  const CustomFastingCard({
    Key? key,
    required this.typeFast,
    required this.onPressed,
    required this.backgroundColor,
    this.fontColor = kBlueDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 169,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: kTextButtonStyle,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 21,
            top: 28,
            right: 26,
            bottom: 22,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.add,
                size: 60,
                color: fontColor,
              ),
              const SizedBox(height: 19),
              Text(
                'Custom Fast',
                style: kSFCaption.copyWith(
                  fontWeight: FontWeight.w400,
                  color: fontColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
