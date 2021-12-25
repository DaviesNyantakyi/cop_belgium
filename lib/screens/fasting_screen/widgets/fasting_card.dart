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
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$duration:${day - duration} TRF',
                    style: kSFBody.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const Flexible(child: SizedBox(height: 15)),
              Expanded(
                flex: 2,
                child: Text(
                  '$duration',
                  style: kSFHeadLine1.copyWith(color: Colors.white),
                ),
              ),
              const Flexible(child: SizedBox(height: 7)),
              Expanded(
                flex: 1,
                child: Text(
                  'Hours',
                  style: kSFCaptionBold.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Expanded(
                child: Icon(
                  Icons.add,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const Flexible(child: SizedBox(height: 19)),
              Expanded(
                child: Text(
                  'Custom Fast',
                  style: kSFCaptionBold.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
