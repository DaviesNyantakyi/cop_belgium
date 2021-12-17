import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/screens/fasting_screen/fasting_history_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dart_date/dart_date.dart';

String _text =
    'Be still, and know that I am God. I will be exalted among the nations, I will be exalted in the earth!';

class FastingScreen extends StatefulWidget {
  static String fastingScreen = 'fastingScreen';
  final FastingInfo? fastingInfo;
  const FastingScreen({Key? key, this.fastingInfo}) : super(key: key);

  @override
  _FastingScreenState createState() => _FastingScreenState();
}

class _FastingScreenState extends State<FastingScreen> {
  final CountDownController _controller = CountDownController();
  bool isFasting = false;
  int peopleFasting = 0;

  FastingInfo? fastingInfo;
  DateTime currenDate = DateTime.now();

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: kGreenLight,
                        borderRadius: BorderRadius.all(
                          Radius.circular(kButtonRadius),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _buildHeader(people: peopleFasting),
                            const SizedBox(height: 30),
                            CircularCountDownTimer(
                              initialDuration: 0,
                              controller: _controller,
                              width: 240,
                              height: 240,
                              duration: fastingInfo!.duration!.inSeconds,
                              isReverse: true,
                              strokeWidth: 20,
                              fillColor:
                                  isFasting == true ? kGreen : Colors.grey,
                              ringColor: Colors.white,
                              strokeCap: StrokeCap.round,
                              textFormat: CountdownTextFormat.HH_MM_SS,
                              textStyle: kSFHeadLine1,
                              autoStart: false,
                              onComplete: () {
                                setState(() {
                                  // reset the fasting timer
                                  isFasting = false;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FastingHistoryScreen(
                                          fastingInfo: fastingInfo,
                                        );
                                      },
                                    ),
                                  );
                                });
                              },
                            ),
                            const SizedBox(height: 30),
                            _buildStartEndDate(
                              startDate: getStartDate(),
                              endDate: getEndDate(),
                            ),
                            const SizedBox(height: 23),
                            _buildBtn(
                              btText: !isFasting
                                  ? 'Start Fasting'
                                  : 'End Fast Early',
                              buttonColor: kGreen,
                              onPressed: () {
                                if (isFasting == false) {
                                  // has started fasting
                                  setState(() {
                                    isFasting = true;
                                    peopleFasting++;
                                    //starts the fasting timer using the conroller
                                    _controller.start();
                                  });
                                } else {
                                  // fasting has been ended
                                  setState(() {
                                    isFasting = false;
                                    peopleFasting--;
                                    //pauses the fasting timer using the conroller
                                    _controller.pause();
                                  });
                                  //TODO: get the current time when the fast has ended early

                                  //TODO:
                                  //before adding to user account in firebase show popup asking to save
                                  // fast. When save is true save to firebase user history
                                  // before pushing add to firebase history screen ad to firebase
                                  // nothing will be passed in the fasting history object
                                  // because it will show the history form firebase
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FastingHistoryScreen(
                                          fastingInfo: fastingInfo,
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: kBodyPadding),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _buildFooterText(
                      passage: _text,
                      verse: '-Psalm 46:10',
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartEndDate({
    required String startDate,
    required String endDate,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Goal',
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
    );
  }

  Widget _buildFooterText({required String passage, required String verse}) {
    return Container(
      margin: const EdgeInsets.only(right: kBodyPadding),
      padding: const EdgeInsets.only(
        left: 21,
        top: 22,
        right: 30,
        bottom: 20,
      ),
      height: 140,
      width: 358,
      decoration: const BoxDecoration(
        color: kGreenLight,
        borderRadius: BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            passage,
            style: kSFBody,
          ),
          const SizedBox(height: 10),
          Text(
            verse,
            style: kSFBody,
          )
        ],
      ),
    );
  }

  Widget _buildBtn({
    required String btText,
    VoidCallback? onPressed,
    Color? buttonColor = kYellowLight,
    Color? textColor = Colors.white,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          btText,
          style: kSFBodyBold.copyWith(color: textColor),
        ),
      ),
    );
  }

  Widget _buildHeader({required int people}) {
    return Column(
      children: [
        Text(
          'You\'r Fasting!',
          style: kSFHeadLine2.copyWith(color: kGreen),
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
      centerTitle: true,
      leading: TextButton(
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            FontAwesomeIcons.chevronLeft,
            color: kDarkBlue,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
