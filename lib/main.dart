import 'package:cop_belgium/screens/fasting_screen/create_fasting_screen.dart';
import 'package:cop_belgium/utilities/audio_provider.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();
  runApp(const MyApp());
}

void init() {
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
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cop Belgium',
      home: const AuthSwitcher(),
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
    elevation: 0,
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
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: 7,
    ),
  ),
);

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateFastingScreens(),
    );
  }
}
