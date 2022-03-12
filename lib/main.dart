import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:cop_belgium/providers/audio_provider.dart';
import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/providers/image_picker_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';

import 'package:cop_belgium/screens/all_screens.dart';

import 'package:provider/provider.dart';

//TODO: -Firebase Project setup IOS

//TODO:  -Image picker IOS

late AudioProvider _audioHandler;

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
  Duration _skipDuration = AudioProvider().skipDuration;

  _audioHandler = await AudioService.init<AudioProvider>(
    builder: () => AudioProvider(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.apkeroo.copBelgium.channel.audio',
      androidNotificationChannelName: 'Cop Belgium',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidResumeOnClick: true,
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
          ChangeNotifierProvider<AudioProvider>.value(
            value: _audioHandler,
          ),
          ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider(),
          ),
          ChangeNotifierProvider<ImagePickerProvider>(
            create: (context) => ImagePickerProvider(),
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

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  ImagePickerProvider imagePickerProvider = ImagePickerProvider();
  File? leaderImage1;
  File? leaderImage2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAvatar1(),
            const SizedBox(height: 10),
            _buildAvatar2(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar1() {
    if (leaderImage1 != null) {
      return CircleAvatar(
        backgroundImage: Image.file(leaderImage1!).image,
        radius: 30,
        backgroundColor: kBlueLight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: TextButton(
            child: Container(),
            onPressed: () async {
              imagePickerProvider.showBottomSheet(context: context);
            },
          ),
        ),
      );
    }
    return CircleAvatar(
      radius: 30,
      backgroundColor: kBlueLight,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: TextButton(
          onPressed: () async {},
          style: kTextButtonStyle,
          child: const Center(
            child: Icon(Icons.person_outline_outlined, color: kBlack),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar2() {
    if (leaderImage2 != null) {
      return CircleAvatar(
        backgroundImage: Image.file(leaderImage2!).image,
        radius: 30,
        backgroundColor: kBlueLight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: TextButton(
            child: Container(),
            onPressed: () async {},
          ),
        ),
      );
    }
    return CircleAvatar(
      radius: 30,
      backgroundColor: kBlueLight,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: TextButton(
          onPressed: () async {},
          style: kTextButtonStyle,
          child: const Center(
            child: Icon(Icons.person_outline_outlined, color: kBlack),
          ),
        ),
      ),
    );
  }
}
