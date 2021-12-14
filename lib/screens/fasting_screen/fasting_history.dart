import 'package:cop_belgium/models/fasting/fasting_duration.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:dart_date/src/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// this will display the fasting history from the user firebase in a acending order
class FastingHistoryScreen extends StatefulWidget {
  final FastingInfo? fastingInfo;
  static String fastingHistoryScreen = 'fastingHistoryScreen';

  const FastingHistoryScreen({Key? key, this.fastingInfo}) : super(key: key);

  @override
  _FastingHistoryScreenState createState() => _FastingHistoryScreenState();
}

class _FastingHistoryScreenState extends State<FastingHistoryScreen> {
  DateTime currenDate = DateTime.now();
  FastingInfo? fastingInfo;

  String getStartDate() {
    return currenDate.format('dd MMM H:mm');
  }

  String getEndDate() {
    return currenDate
        .add(Duration(seconds: fastingInfo!.duration!.inSeconds))
        .format('dd MMM H:mm');
  }

  @override
  void initState() {
    super.initState();
    fastingInfo = widget.fastingInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: FastingHistoryCard(
                duration: fastingInfo!.duration!.inHours,
                startDate: getStartDate(),
                endDate: getEndDate(),
              ),
            );
          },
        ),
      ),
    );
  }

  dynamic _buildAppbar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Fasting History',
        style: kSFCaption,
      ),
      leading: TextButton(
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: kAppbarPadding),
          child: Icon(
            FontAwesomeIcons.chevronLeft,
            color: kBlueDark,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }
}

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
      width: 310,
      height: 87,
      decoration: const BoxDecoration(
        color: kGreen1Light,
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
        color: kGreen1Light,
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
