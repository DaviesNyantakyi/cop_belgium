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

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
  splashColor: kBlue,
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

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Container(
                child: const Text(
                  'Hello world',
                  style: kSFHeadLine1,
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            SizedBox(
              width: 300,
              child: Container(
                child: const Text(
                  'Hello world',
                  style: kSFHeadLine2,
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Hello world',
                      style: kSFCaptionBold,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  const Text(
                    'Hello worldAmet nostrud culpa velit qui culpa culpa aliquip esse minim incididunt. Eiusmod aliqua enim occaecat amet minim do ut. Consequat nisi eiusmod aute ipsum excepteur cillum culpa dolor ea. Veniam elit esse ad ipsum. Cillum exercitation et veniam Lorem ex excepteur sit reprehenderit in consequat aute cupidatat cillum. Exercitation laboris eiusmod aute ullamco aute excepteur. Mollit non ad velit ullamco ea eu incididunt incididunt incididunt sunt.',
                    style: kSFBody,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
