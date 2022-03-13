import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/screens/fasting_screen/fasting_details_screen.dart';
import 'package:cop_belgium/screens/fasting_screen/fasting_history_screen.dart';

import 'package:cop_belgium/services/cloud_fire.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String _text =
    'Be still, and know that I am God. I will be exalted among the nations, I will be exalted in the earth!';

class FastingTimerScreen extends StatefulWidget {
  static String fastingTimerScreen = 'fastingTimerScreen';
  final FastingInfo? fastingInfo;
  const FastingTimerScreen({Key? key, this.fastingInfo}) : super(key: key);

  @override
  _FastingTimerScreenState createState() => _FastingTimerScreenState();
}

class _FastingTimerScreenState extends State<FastingTimerScreen> {
  final CountDownController _controller = CountDownController();

  // if fasle not started fasting
  bool isFasting = false;
  int peopleFasting = 0;
  DateTime? endDate;
  String? note;

  FastingInfo? fastingInfo;

  String getStartDate() {
    return FormalDates.formatEDmyyyy(date: fastingInfo!.startDate);
  }

  String getEndDate() {
    return FormalDates.getFastGoalDate(fastingInfo: fastingInfo);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fastingInfo = widget.fastingInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding).copyWith(top: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(color: kGreen, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildHeader(people: peopleFasting),
                      const SizedBox(height: 30),
                      _buildTimer(context),
                      const SizedBox(height: 30),
                      _buildStartEndDate(),
                      const SizedBox(height: 23),
                      _buildStartEndButton()
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildVersesList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVersesList() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        itemCount: 20,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return TextButton(
            onPressed: () {
              _showBottomSheet(
                context: context,
                chapter: '-Psalm 46:10',
                verse: _text,
              );
            },
            style: kTextButtonStyle,
            child: Container(
              margin: const EdgeInsets.only(right: kBodyPadding),
              padding: const EdgeInsets.only(
                left: 20,
                top: 21,
                right: 29,
                bottom: 19,
              ),
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: kGreen, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(kButtonRadius),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _text,
                    style: kSFBody,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '-Psalm 46:10',
                    style: kSFBody,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimer(BuildContext context) {
    return CircularCountDownTimer(
      initialDuration: 0,
      controller: _controller,
      width: 240,
      height: 240,
      duration: fastingInfo!.duration.inSeconds,
      isReverse: true,
      strokeWidth: 20,
      fillColor: isFasting == true ? kGreen : Colors.grey.shade300,
      ringColor: Colors.grey.shade300,
      strokeCap: StrokeCap.round,
      textFormat: CountdownTextFormat.HH_MM_SS,
      textStyle: kSFHeadLine1,
      autoStart: false,
      onComplete: () async {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const FastingDetailsScreen(),
          ),
        );
      },
    );
  }

  Future<void> submitFast() async {
    // fasting has ended.
    setState(() {
      _controller.pause();
      isFasting = false;
      peopleFasting--;

      endDate = DateTime.now();
      fastingInfo!.endDate = endDate;
      fastingInfo!.userId = FirebaseAuth.instance.currentUser!.uid;
      fastingInfo!.note = note;
    });

    try {
      await CloudFire().createFastHistory(fInfo: fastingInfo!);
      await Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const FastingHistoryScreen(),
        ),
      );
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> startFasting() async {
    setState(() {
      isFasting = true;
      peopleFasting++;

      _controller.start();
    });
  }

  Widget _buildStartEndButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kGreen),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: () async {
          if (isFasting == false) {
            // isnot started fasting
            startFasting();
          } else {
            _controller.pause();
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const FastingDetailsScreen(),
              ),
            );
          }
        },
        child: Text(
          !isFasting ? 'Start fasting' : 'End fast early',
          style: kSFBodyBold.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildStartEndDate() {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Start Time',
                      style: kSFBodyBold,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      getStartDate(),
                      style: kSFBody,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Goal',
                      style: kSFBodyBold,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      getEndDate(),
                      style: kSFBody,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showBottomSheet({
    required BuildContext context,
    required String chapter,
    required String verse,
  }) {
    return showMyBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              chapter,
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              _text,
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({required int people}) {
    return Column(
      children: [
        const Text(
          'You\'r Fasting!',
          style: kSFHeadLine2,
        ),
        Text(
          '$people People are fasting right now',
          style: kSFBody,
        ),
      ],
    );
  }

  dynamic _buildAppbar() {
    return AppBar(
      elevation: kAppbarElevation,
      leading: kBackButton(context: context),
    );
  }
}
