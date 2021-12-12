import 'package:cop_belgium/screens/podcast_screen/play_podcast_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_detail_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen/edit_testimony_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cop_belgium/screens/announcement_screen/announcement.dart';
import 'package:cop_belgium/screens/fasting_screen/fasting_screen.dart';
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
      home: const HomeScreen(),
      theme: _theme,
      routes: {
        WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
        HomeScreen.homeScreen: (context) => const HomeScreen(),
        PodcastScreen.podcastScreen: (context) => const PodcastScreen(),
        PlayPodcastScreen.playPodcastScreen: (context) =>
            const PlayPodcastScreen(),
        PodcastDetailScreen.podcastDetailScreen: (context) =>
            const PodcastDetailScreen(),
        AnnouncementScreen.announcementScreen: (context) =>
            const AnnouncementScreen(),
        TestimoniesScreen.testimoniesScreen: (context) =>
            const TestimoniesScreen(),
        FastingScreens.fastingScreens: (context) => const FastingScreens(),
        ProfileScreens.profileScreens: (context) => const ProfileScreens(),
        EditTestimonyScreen.editTestimonyScreen: (context) =>
            const EditTestimonyScreen(),
      },
    );
  }
}

ThemeData _theme = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  sliderTheme: SliderThemeData(
    activeTrackColor: kBlue,
    thumbColor: kBlue,
    inactiveTrackColor: Colors.grey,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
    overlayShape: SliderComponentShape.noThumb, // removes padding
  ),
);
