import 'package:cop_belgium/screens/fasting_screen/fasting_history.dart';
import 'package:cop_belgium/screens/fasting_screen/fasting_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/play_podcast_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_detail_screen.dart';
import 'package:cop_belgium/screens/profile_screen/edit_profile_screen.dart';
import 'package:cop_belgium/screens/profile_screen/fasting_view.dart';
import 'package:cop_belgium/screens/profile_screen/saved_podcast_view.dart';
import 'package:cop_belgium/screens/profile_screen/testimonies_view.dart';
import 'package:cop_belgium/screens/settings_screen/settings_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/edit_testimony_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cop_belgium/screens/announcement_screen/announcement.dart';
import 'package:cop_belgium/screens/fasting_screen/create_fasting_screen.dart';
import 'package:cop_belgium/screens/home_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_screen.dart';
import 'package:cop_belgium/screens/profile_screen/profile_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/testimonies_screen.dart';
import 'package:cop_belgium/screens/welcome_screen/welcome_screen.dart';

void main() {
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
      home: const WelcomeScreen(),
      theme: _theme,
      routes: _routes,
    );
  }
}

Map<String, WidgetBuilder> _routes = {
  WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
  HomeScreen.homeScreen: (context) => const HomeScreen(),
  AnnouncementScreen.announcementScreen: (context) =>
      const AnnouncementScreen(),
  PodcastScreen.podcastScreen: (context) => const PodcastScreen(),
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
  UserFastingView.userFastingView: (context) => const UserFastingView(),
  ProfileScreens.profileScreens: (context) => const ProfileScreens(),
  EditProfileScreen.editProfileScreen: (context) => const EditProfileScreen(),
  SettingsScreen.settingsScreen: (context) => const SettingsScreen(),
  CreateTestimonyScreen.editTestimonyScreen: (context) =>
      const CreateTestimonyScreen(),
  TestimoniesScreen.testimoniesScreen: (context) => const TestimoniesScreen(),
  UserTestimoniesView.userTestimoniesView: (context) =>
      const UserTestimoniesView(),
};

ThemeData _theme = ThemeData(
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
    activeTrackColor: kBlue,
    thumbColor: kBlue,
    inactiveTrackColor: Colors.grey,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
    overlayShape: SliderComponentShape.noThumb, // removes padding
  ),
);
