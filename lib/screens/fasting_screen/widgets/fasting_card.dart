import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class PresetFastingCard extends StatelessWidget {
  final String typeFast;
  final int duration;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const PresetFastingCard({
    Key? key,
    required this.typeFast,
    required this.duration,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int day = 24;
    return Container(
      width: 160,
      height: 167,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$duration:${day - duration} TRF',
                  style: kSFBody.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '$duration',
                style: kSFHeadLine1.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 7),
              Text(
                'Hours',
                style: kSFCaptionBold.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
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

  final Color fontColor;
  const CustomFastingCard({
    Key? key,
    required this.typeFast,
    required this.onPressed,
    this.fontColor = kBlueDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 167,
      decoration: BoxDecoration(
        color: kGrey,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
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
              const Icon(
                Icons.add,
                size: 60,
                color: Colors.white,
              ),
              const SizedBox(height: 19),
              Text(
                'Custom Fast',
                style: kSFCaptionBold.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
