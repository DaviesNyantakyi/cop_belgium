// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'package:cop_belgium/providers/audio_notifier.dart';
import 'package:cop_belgium/providers/signup_notifier.dart';
import 'package:cop_belgium/screens/auth_screens/auth_wrapper.dart';
import 'package:cop_belgium/utilities/constant.dart';

//TODO: -Firebase Project setup IOS

//TODO:  -Image picker IOS

late AudioPlayerNotifier _audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 5
    ..indicatorWidget = kCircularProgressIndicator
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;

  // Initialize the notifications and expose the AudioProvider class
  Duration _skipDuration = AudioPlayerNotifier().skipDuration;

  _audioHandler = await AudioService.init<AudioPlayerNotifier>(
    builder: () => AudioPlayerNotifier(),
    config: AudioServiceConfig(
      androidNotificationChannelName: 'Cop Belgium',
      androidNotificationChannelId: 'com.apkeroo.copBelgium.channel.audio',
      androidNotificationIcon: 'drawable/notifcation_icon',
      androidStopForegroundOnPause: true,
      fastForwardInterval: _skipDuration,
      rewindInterval: _skipDuration,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cop Belgium',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<AudioPlayerNotifier>.value(
            value: _audioHandler,
          ),
          ChangeNotifierProvider<SignUpNotifier>(
            create: (context) => SignUpNotifier(),
          ),
        ],
        child: const AuthWrapper(),
      ),
      theme: _theme,
      builder: EasyLoading.init(),
    );
  }
}

ThemeData _theme = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kBlue,
  ),
  dividerTheme: const DividerThemeData(thickness: 1),
  iconTheme: const IconThemeData(
    color: kBlack,
    size: kIconSize,
  ),
  appBarTheme: const AppBarTheme(
    elevation: kAppbarElevation,
    iconTheme: IconThemeData(
      size: kIconSize,
      color: kBlack,
    ),
    backgroundColor: Colors.white,
    titleTextStyle: kSFHeadLine3,
  ),
  scaffoldBackgroundColor: Colors.white,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kBlack,
    selectionHandleColor: kBlack,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: kBlack,
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: kBlue,
    thumbColor: kBlue,
    inactiveTrackColor: Colors.grey.shade300,
    trackShape: CustomTrackShape(),
  ),
);

// Slider padding
class CustomTrackShape extends RoundedRectSliderTrackShape {
  //From StackOverFlow
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class TestModel {
  String? text;
  TestModel({
    this.text,
  });
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<TestModel> tests = List<TestModel>.filled(5, TestModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: tests.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.yellow,
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.all(10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(tests[index].text ?? ''),
                                TextFormField(
                                  onChanged: (value) {
                                    tests[index].text = value;
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                            onPressed: () {
                              tests.removeAt(index);
                              FocusScope.of(context).unfocus();
                              setState(() {});
                            },
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('Add'),
                      onPressed: () {
                        tests.add(TestModel(text: 'hallo ${tests.length + 1}'));
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tests.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(tests[index].text ?? ''),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
