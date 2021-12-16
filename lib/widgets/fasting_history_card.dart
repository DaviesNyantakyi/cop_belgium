import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

class FastingHistoryCard extends StatelessWidget {
  final String startDate;
  final String endDate;
  final int duration;

  const FastingHistoryCard({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 378,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDurationHeader(duration: duration),
          _buildStartEndInfo(startDate: startDate, endDate: endDate),
        ],
      ),
    );
  }

  Widget _buildStartEndInfo(
      {required String startDate, required String endDate}) {
    return Container(
      width: 300,
      height: 87,
      decoration: const BoxDecoration(
        color: kGreenLight,
        borderRadius: BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Start Time',
                      style: kSFSubtitle2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      startDate,
                      style: kSFCaption,
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'End Time',
                      style: kSFSubtitle2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      endDate,
                      style: kSFCaption,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationHeader({required int duration}) {
    return Container(
      width: 60,
      height: 83,
      decoration: const BoxDecoration(
        color: kGreenLight,
        borderRadius: BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$duration',
            style: kSFHeadLine2,
          ),
          const Text(
            'Hours',
            style: kSFBody,
          )
        ],
      ),
    );
  }
}
