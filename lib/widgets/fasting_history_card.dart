import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';

const double _cardHeight = 100;

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

  @override
  void initState() {
    super.initState();

    if (widget.fastingInfo.endDate!.isBefore(widget.fastingInfo.goalDate!)) {
      cardColor = kRed.withOpacity(0.5);
    } else {
      cardColor = kGreen.withOpacity(0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildGoalDuration(fastingInfo: widget.fastingInfo),
            const SizedBox(width: 10),
            _buildTotalDuration(fastingInfo: widget.fastingInfo),
            const SizedBox(width: 10),
            _buildEstimatedTimes(fastingInfo: widget.fastingInfo),
          ],
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                CloudFireStore().deleteFastHistory(fInfo: widget.fastingInfo);
              },
            ),
          ),
        )
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
            style: kSFCaption,
          ),
          Text(
            '${fastingInfo.duration.inHours}',
            style: kSFHeadLine2,
          ),
          const Text(
            'Hrs',
            style: kSFCaption,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalDuration({required FastingInfo fastingInfo}) {
    int totalFastDuration =
        fastingInfo.endDate!.hour - fastingInfo.startDate!.hour;

    return Container(
      width: 70,
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
            style: kSFCaption,
          ),
          Text(
            '$totalFastDuration',
            style: kSFHeadLine2,
          ),
          const Text(
            'Hrs',
            style: kSFCaption,
          ),
        ],
      ),
    );
  }

  Widget _buildEstimatedTimes({required FastingInfo fastingInfo}) {
    String startedDate = FormalDates.formatDmyy(date: fastingInfo.startDate);
    String startedTime = FormalDates.formatHm(date: fastingInfo.startDate);
    String endDate = FormalDates.formatDmyy(date: fastingInfo.endDate);
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
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Text(
                            'Started fasting',
                            style: kSFCaption,
                          ),
                        ),
                        const Flexible(child: SizedBox(height: 4)),
                        Flexible(
                          child: Text(
                            startedDate,
                            style: kSFBodyBold,
                          ),
                        ),
                        const Flexible(child: SizedBox(height: 4)),
                        Flexible(
                          child: Text(
                            startedTime,
                            style: kSFCaption,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Text(
                            'End',
                            style: kSFCaption,
                          ),
                        ),
                        const Flexible(child: SizedBox(height: 4)),
                        Flexible(
                          child: Text(
                            endDate,
                            style: kSFBodyBold,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            endTime,
                            style: kSFCaption,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
