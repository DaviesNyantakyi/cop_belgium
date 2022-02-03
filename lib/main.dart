import 'dart:math';

import 'package:cop_belgium/utilities/audio_provider.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<AudioProvider>(
            create: (context) => AudioProvider(),
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
  ),
);

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    Provider.of<AudioProvider>(context, listen: false).setUrl(
      url:
          'https://stream.redcircle.com/episodes/58ea3c7d-2079-4ed3-bc0d-19e507486d3d/stream.mp3',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    Provider.of<AudioProvider>(context, listen: false).play();
                  },
                  icon: Icon(
                    Provider.of<AudioProvider>(context).isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
              ],
            ),
            Slider(
              min: 0.0,
              max: Provider.of<AudioProvider>(context)
                  .totalDuration
                  .inMilliseconds
                  .toDouble(),
              value: min(
                  Provider.of<AudioProvider>(context)
                      .currentPostion
                      .inMilliseconds
                      .toDouble(),
                  Provider.of<AudioProvider>(context)
                      .totalDuration
                      .inMilliseconds
                      .toDouble()),
              onChanged: (value) {
                Provider.of<AudioProvider>(context, listen: false).seek(
                  newPosition: value.toInt(),
                );
              },
              onChangeEnd: (value) {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    FormalDates.getEpisodeDuration(
                      duration:
                          Provider.of<AudioProvider>(context).currentPostion,
                    ),
                  ),
                  Text(
                    FormalDates.getEpisodeDuration(
                      duration:
                          Provider.of<AudioProvider>(context).totalDuration,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<AudioProvider>(context, listen: false)
                          .fastRewind();
                    },
                    icon: const Icon(Icons.fast_rewind),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<AudioProvider>(context, listen: false)
                          .fastForward();
                    },
                    icon: const Icon(Icons.fast_forward),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
