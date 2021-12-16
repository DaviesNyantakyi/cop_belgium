import 'package:cop_belgium/models/fasting/fasting_duration.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:cop_belgium/widgets/fasting_history_card.dart';
import 'package:dart_date/src/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//TODO: Fix overflow errow on smaller device

//TODO: this will display the fasting history from the user firebase in a acending order

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
            color: kDarkBlue,
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
