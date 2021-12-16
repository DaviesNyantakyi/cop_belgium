import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

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
    this.fontColor = kDarkBlue,
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
    this.fontColor = kDarkBlue,
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
