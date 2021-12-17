import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

const double _cardHeight = 87.13;

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(duration: duration),
        const SizedBox(width: 10),
        _buildTrailing(startDate: startDate, endDate: endDate),
      ],
    );
  }

  Widget _buildHeader({required int duration}) {
    return Container(
      width: 60,
      height: _cardHeight,
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

  Widget _buildTrailing({required String startDate, required String endDate}) {
    return Flexible(
      child: Container(
        height: _cardHeight,
        width: 310,
        decoration: const BoxDecoration(
          color: kGreenLight,
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
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
                      style: kSFCaptionBold,
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
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
                      style: kSFCaptionBold,
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
}
