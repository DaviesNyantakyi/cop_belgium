import 'package:audio_service/audio_service.dart';
import 'package:cop_belgium/providers/audio_provider.dart';
import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/screens/more_screen/more_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';

import 'package:cop_belgium/screens/all_screens.dart';
import 'package:provider/provider.dart';

//TODO: Firebase project setup
//-Password recovery message: link and sender email

//TODO: -Ios setup
//-iOS Firebase Project Setup

//TODO:  -Image picker
//    - image picker setup ios

//TODO:  Authors project
//   - type in vs code command pallet: Authors

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
    ..indicatorWidget = kProgressIndicator
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;

  // Initialize the notifications and expose the AudioProvider class
  Duration _skipDuration = AudioProvider().skipDuration;

  _audioHandler = await AudioService.init<AudioProvider>(
    builder: () => AudioProvider(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.apkeroo.cop_belgium.channel.audio',
      androidNotificationChannelName: 'Cop Belgium',
      androidNotificationOngoing: true,
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
          ChangeNotifierProvider<AudioProvider>.value(
            value: _audioHandler,
          ),
          ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider(),
          ),
        ],
        child: const AuthSwitcher(),
      ),
      theme: _theme,
      routes: _routes,
      builder: EasyLoading.init(),
    );
  }
}

Map<String, WidgetBuilder> _routes = {
  LoginScreen.loginScreen: (context) => const LoginScreen(),
  SignUpScreen.signUpScreen: (context) => const SignUpScreen(),
  AuthSwitcher.authScreenSwitcher: (context) => const AuthSwitcher(),
  ForgotPasswordScreen.forgotPasswordScreen: (context) =>
      const ForgotPasswordScreen(),
  BottomNavSelectorPage.bottomNavSelectorPage: (context) =>
      const BottomNavSelectorPage(),
  PodcastScreen.podcastScreen: (context) => const PodcastScreen(),
  PodcastPlayerScreen.podcastPlayerScreen: (context) =>
      const PodcastPlayerScreen(),
  PodcastDetailScreen.podcastDetailScreen: (context) =>
      const PodcastDetailScreen(),
  SavedPodcastView.userSavedPodcastView: (context) => const SavedPodcastView(),
  ProfileScreens.profileScreens: (context) => const ProfileScreens(),
  EditProfileScreen.editProfileScreen: (context) => const EditProfileScreen(),
  SettingsScreen.settingsScreen: (context) => const SettingsScreen(),
  AboutChruchScreen.aboutChruchScreen: (context) => const AboutChruchScreen(),
  CreateTestimonyScreen.createTestimonyScreen: (context) =>
      const CreateTestimonyScreen(),
  TestimoniesScreen.testimoniesScreen: (context) => const TestimoniesScreen(),
  UserTestimoniesView.userTestimoniesView: (context) =>
      const UserTestimoniesView(),
};

ThemeData _theme = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kBlue,
  ),
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
