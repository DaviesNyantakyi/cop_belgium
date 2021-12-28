import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/services/podcast_rss_handler.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/my_skeleton_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cop_belgium/screens/all_screens.dart';
import 'package:provider/provider.dart';
//import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
            ChangeNotifierProvider<ConnectionChecker>(
              create: (_) => ConnectionChecker(),
            ),
          ],
          child: const AuthScreenSwitcher(),
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
  AuthScreenSwitcher.authScreenSwitcher: (context) =>
      const AuthScreenSwitcher(),
  ForgotPasswordScreen.forgotPasswordScreen: (context) =>
      const ForgotPasswordScreen(),
  BottomNavSelectorPage.bottomNavSelectorPage: (context) =>
      const BottomNavSelectorPage(),
  AnnouncementScreen.announcementScreen: (context) =>
      const AnnouncementScreen(),
  PodcastScreen.podcastScreen: (context) => const PodcastScreen(),
  // SeeAllPodCastScreen.seeAllPodCastScreen: (context) =>
  //     const SeeAllPodCastScreen(),
  PlayPodcastScreen.playPodcastScreen: (context) => const PlayPodcastScreen(),
  PodcastDetailScreen.podcastDetailScreen: (context) =>
      const PodcastDetailScreen(),
  UserSavedPodcastView.userSavedPodcastView: (context) =>
      const UserSavedPodcastView(),
  CreateFastingScreens.createFastingScreens: (context) =>
      const CreateFastingScreens(),
  FastingTimerScreen.fastingTimerScreen: (context) =>
      const FastingTimerScreen(),
  FastingHistoryScreen.fastingHistoryScreen: (context) =>
      const FastingHistoryScreen(),
  UserFastingHistoryView.userFastingHistoryView: (context) =>
      const UserFastingHistoryView(),
  ProfileScreens.profileScreens: (context) => const ProfileScreens(),
  EditProfileScreen.editProfileScreen: (context) =>
      const EditProfileScreen(user: null),
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
  splashColor: kBlueLight2,
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
  sliderTheme: SliderThemeData(
    activeTrackColor: kBlueDark,
    thumbColor: kBlueDark,
    inactiveTrackColor: Colors.grey,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
    overlayShape: SliderComponentShape.noThumb, // removes padding
  ),
);

/*
class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: PresetFastingCard(
                    onPressed: () {},
                    duration: 10,
                    backgroundColor: kIndigo,
                    typeFast: 'Preset',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: PodcastCard(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/
