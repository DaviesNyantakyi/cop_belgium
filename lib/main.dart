import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:cop_belgium/providers/audio_provider.dart';
import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/screens/auth_screens/auth_switcher.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

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
  MyImagePicker myImagePicker1 = MyImagePicker();
  MyImagePicker myImagePicker2 = MyImagePicker();

  File? image1;
  File? image2;

  Future<void> pickImage1() async {
    await myImagePicker1.showBottomSheet(
      context: context,
    ) as File?;

    image1 = myImagePicker1.image;

    setState(() {});
  }

  Future<void> pickImage2() async {
    await myImagePicker2.showBottomSheet(
      context: context,
    ) as File?;

    image2 = myImagePicker2.image;

    setState(() {});
  }

  String url =
      'Zoom link: https://zoom.us/j/94548805427?pwd=TFZNRlFwN242dkJQeXliWWJPdEovQT09#success';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImage(
          file: image1,
          onPressed: pickImage1,
        ),
        _buildImage(
          file: image2,
          onPressed: pickImage2,
        ),
        Linkify(
          text: url,
          style: kSFBody,
          onOpen: (link) async {
            if (await url_launcher.canLaunch(link.url)) {
              await url_launcher.launch(link.url);
            } else {
              throw 'Could not launch $link';
            }
          },
        )
      ],
    );
  }

  Widget _buildImage({required File? file, required VoidCallback onPressed}) {
    if (file?.path != null && file != null) {
      return CircleAvatar(
        radius: 90,
        backgroundImage: Image.file(
          file,
          fit: BoxFit.cover,
        ).image,
        backgroundColor: kBlueLight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: TextButton(
            onPressed: onPressed,
            style: kTextButtonStyle,
            child: Container(),
          ),
        ),
      );
    }
    return CircleAvatar(
      radius: 90,
      backgroundColor: kBlueLight,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: kTextButtonStyle,
          child: const Center(
            child: Icon(Icons.collections_outlined, color: kBlack),
          ),
        ),
      ),
    );
  }
}
