import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';

const double _cardHeight = 87.13;

class FastingHistoryCard extends StatefulWidget {
  final FastingInfo fastingInfo;

  const FastingHistoryCard({
    Key? key,
    required this.fastingInfo,
  }) : super(key: key);

  @override
  State<FastingHistoryCard> createState() => _FastingHistoryCardState();
}

class _FastingHistoryCardState extends State<FastingHistoryCard> {
  Color? cardColor;

  // changed card color if the goal is reached.
  // if the endFast == goal Colors green
  // if the endFast < goal Colors red

  @override
  void initState() {
    super.initState();

    if (widget.fastingInfo.endDate!.isBefore(widget.fastingInfo.goalDate!)) {
      cardColor = kRedLight2;
    } else {
      cardColor = kGreenLight2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildGoalDuration(fastingInfo: widget.fastingInfo),
        const SizedBox(width: 10),
        _buildTotalDuration(fastingInfo: widget.fastingInfo),
        const SizedBox(width: 10),
        _buildEstimatedTimes(fastingInfo: widget.fastingInfo),
      ],
    );
  }

  Widget _buildGoalDuration({required FastingInfo fastingInfo}) {
    return Container(
      width: 60,
      height: _cardHeight,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Goal',
            style: kSFSubtitle2,
          ),
          Text(
            '${fastingInfo.duration.inHours}',
            style: kSFCaptionBold,
          ),
          const Text(
            'Hrs',
            style: kSFSubtitle2,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalDuration({required FastingInfo fastingInfo}) {
    int totalFastDuration =
        fastingInfo.endDate!.hour - fastingInfo.startDate!.hour;

    return Container(
      width: 60,
      height: _cardHeight,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Duration ',
            style: kSFSubtitle2,
          ),
          Text(
            '${totalFastDuration}',
            style: kSFCaptionBold,
          ),
          const Text(
            'Hrs',
            style: kSFSubtitle2,
          ),
        ],
      ),
    );
  }

  Widget _buildEstimatedTimes({required FastingInfo fastingInfo}) {
    String startedDate = FormalDates.formatDmy(date: fastingInfo.startDate);
    String startedTime = FormalDates.formatHm(date: fastingInfo.startDate);
    String endDate = FormalDates.formatDmy(date: fastingInfo.endDate);
    String endTime = FormalDates.formatHm(date: fastingInfo.endDate);
    return Flexible(
      child: Container(
        height: _cardHeight,
        width: 310,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.all(
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
                      'Started fasting',
                      style: kSFSubtitle2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      startedDate,
                      style: kSFBodyBold,
                    ),
                    Text(
                      startedTime,
                      style: kSFBody,
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
                      'End',
                      style: kSFSubtitle2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      endDate,
                      style: kSFBodyBold,
                    ),
                    Text(
                      endTime,
                      style: kSFBody,
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
