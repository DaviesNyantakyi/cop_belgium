import 'package:cop_belgium/screens/fasting_screen/fasting_history_screen.dart';
import 'package:cop_belgium/screens/fasting_screen/fasting_screen.dart';
import 'package:cop_belgium/screens/fasting_screen/widgets/fasting_card.dart';
import 'package:cop_belgium/screens/podcast_screen/play_podcast_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_detail_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/see_all_podcasts.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_card.dart';
import 'package:cop_belgium/screens/profile_screen/edit_profile_screen.dart';
import 'package:cop_belgium/screens/profile_screen/fasting_history_view.dart';
import 'package:cop_belgium/screens/profile_screen/saved_podcast_view.dart';
import 'package:cop_belgium/screens/profile_screen/testimonies_view.dart';
import 'package:cop_belgium/screens/settings_screen/about_church_screen.dart';
import 'package:cop_belgium/screens/settings_screen/settings_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/create_testimony_screen.dart';
import 'package:cop_belgium/screens/welcome_screen/forgot_password_screen.dart';
import 'package:cop_belgium/screens/welcome_screen/sign_up_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cop_belgium/screens/announcement_screen/announcement.dart';
import 'package:cop_belgium/screens/fasting_screen/create_fasting_screen.dart';
import 'package:cop_belgium/screens/home_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_screen.dart';
import 'package:cop_belgium/screens/profile_screen/profile_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/testimonies_screen.dart';
import 'package:cop_belgium/screens/welcome_screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cop Belgium',
      home: const SignUpScreen(),
      theme: _theme,
      routes: _routes,
    );
  }
}

Map<String, WidgetBuilder> _routes = {
  WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
  SignUpScreen.signUpScreen: (context) => const SignUpScreen(),
  ForgotPasswordScreen.forgotPasswordScreen: (context) =>
      const ForgotPasswordScreen(),
  HomeScreen.homeScreen: (context) => const HomeScreen(),
  AnnouncementScreen.announcementScreen: (context) =>
      const AnnouncementScreen(),
  PodcastScreen.podcastScreen: (context) => const PodcastScreen(),
  SeeAllPodCastScreen.seeAllPodCastScreen: (context) =>
      const SeeAllPodCastScreen(),
  PlayPodcastScreen.playPodcastScreen: (context) => const PlayPodcastScreen(),
  PodcastDetailScreen.podcastDetailScreen: (context) =>
      const PodcastDetailScreen(),
  UserSavedPodcastView.userSavedPodcastView: (context) =>
      const UserSavedPodcastView(),
  CreateFastingScreens.createFastingScreens: (context) =>
      const CreateFastingScreens(),
  FastingScreen.fastingScreen: (context) => const FastingScreen(),
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
  splashColor: kBlueLight,
  iconTheme: const IconThemeData(
    color: kBlueDark,
    size: 25,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      size: 25,
      color: kBlueDark,
      opacity: 0.5,
    ),
    elevation: 0,
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
                  child: PodcastCard(
                    image: 'assets/images/Rectangle 269.png',
                    title:
                        'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
                    episodes: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
