import 'package:cop_belgium/screens/fasting_screen/create_fasting_screen.dart';
import 'package:cop_belgium/services/podcast_handlre.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/my_skeleton_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';

import 'package:cop_belgium/screens/all_screens.dart';

import 'package:provider/provider.dart';

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
    ..indicatorWidget = kCircularProgress
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MySkeletonTheme(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cop Belgium',
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<PodcastHandler>(
              create: (_) => PodcastHandler(),
            )
          ],
          child: const AuthSwitcher(),
        ),
        theme: _theme,
        routes: _routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}

Map<String, WidgetBuilder> _routes = {
  WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
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
  UserSavedPodcastView.userSavedPodcastView: (context) =>
      const UserSavedPodcastView(),
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
    backgroundColor: kBlueDark,
  ),
  iconTheme: const IconThemeData(
    color: kBlueDark,
    size: 25,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(
      size: 25,
      color: kBlueDark,
      opacity: 0.5,
    ),
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kBlueDark,
    selectionHandleColor: kBlueDark,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: kBlueDark,
  ),
  sliderTheme: SliderThemeData(
    trackHeight: 16.0,

    activeTrackColor: kBlueDark,
    thumbColor: kBlueDark,
    inactiveTrackColor: Colors.grey.shade300,
    thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 9, elevation: 0, pressedElevation: 0),
    overlayShape: SliderComponentShape.noThumb, // removes padding
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
