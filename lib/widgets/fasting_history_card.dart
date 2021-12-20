import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';

const double _cardHeight = 87.13;

class FastingHistoryCard extends StatelessWidget {
  final FastingInfo fastingInfo;

  const FastingHistoryCard({
    Key? key,
    required this.fastingInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(duration: fastingInfo.duration.inHours),
        const SizedBox(width: 10),
        _buildTrailing(
          startDate: FormalDates.format(date: fastingInfo.startDate),
          endDate: FormalDates.format(date: fastingInfo.endDate),
        ),
      ],
    );
  }

  Widget _buildHeader({required int duration}) {
    return Container(
      width: 60,
      height: _cardHeight,
      decoration: const BoxDecoration(
        color: kGreenLight2,
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
          color: kGreenLight2,
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
