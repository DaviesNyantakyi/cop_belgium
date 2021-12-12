import 'package:cop_belgium/screens/fasting_screen.dart';
import 'package:cop_belgium/screens/home_screen.dart';
import 'package:cop_belgium/screens/podcast_screen.dart';
import 'package:cop_belgium/screens/profile_screen.dart';
import 'package:cop_belgium/screens/testimonies_screen.dart';
import 'package:cop_belgium/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cop Belgium',
      home: const WelcomeScreen(),
      theme: _theme,
      routes: {
        WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
        HomeScreen.homeScreen: (context) => const HomeScreen(),
        PodcastScreen.podcastScreen: (context) => const PodcastScreen(),
        TestimoniesScreen.testimoniesScreen: (context) =>
            const TestimoniesScreen(),
        FastingScreens.fastingScreens: (context) => const FastingScreens(),
        ProfileScreens.profileScreens: (context) => const ProfileScreens(),
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
);
