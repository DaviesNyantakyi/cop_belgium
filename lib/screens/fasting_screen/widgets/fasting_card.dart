import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double _size = 170;

class PresetFastingCard extends StatelessWidget {
  final int duration;
  final VoidCallback onPressed;
  final Gradient backgroundGradient;

  const PresetFastingCard({
    Key? key,
    required this.duration,
    required this.onPressed,
    required this.backgroundGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int day = 24;
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          kBoxShadow,
        ],
        gradient: backgroundGradient,
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
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$duration:${day - duration} TRF',
                  style: kSFBody.copyWith(color: Colors.white),
                ),
              ),
              const Flexible(child: SizedBox(height: 37)),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$duration',
                    style: kSFHeadLine1.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  const Flexible(child: SizedBox(height: 3)),
                  Text(
                    'Hours',
                    style: kSFCaptionBold.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFastingCard extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFastingCard({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: kBlueDark2,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          kBoxShadow,
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
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Flexible(child: SizedBox(height: 10)),
              const Expanded(
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 31,
                  color: Colors.white,
                ),
              ),
              const Flexible(child: SizedBox(height: 10)),
              Expanded(
                child: Text(
                  'Custom Fast',
                  style: kSFBodyBold.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
