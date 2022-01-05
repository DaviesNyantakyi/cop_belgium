import 'package:cop_belgium/services/podcast_handlre.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cop_belgium/screens/all_screens.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';

class AuthSwitcher extends StatefulWidget {
  static String authScreenSwitcher = 'authScreenSwitcher';
  const AuthSwitcher({Key? key}) : super(key: key);

  @override
  _AuthSwitcherState createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await checkConnnection();

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }

    final newVersion = NewVersion();

    try {
      await Provider.of<PodcastHandler>(context, listen: false).getPodcasts();
    } on FirebaseException catch (e) {
      kshowSnackbar(
        context: context,
        errorType: 'error',
        text: e.message.toString(),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> checkConnnection() async {
    // check internet connection when the app starts
    await Provider.of<ConnectionChecker>(context, listen: false)
        .intializeConnectionChecker();
    return Provider.of<ConnectionChecker>(context, listen: false).hasConnection;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snaphot) {
        if (snaphot.connectionState == ConnectionState.active) {
          if (snaphot.hasData && snaphot.data?.uid != null) {
            return const BottomNavSelectorPage();
          }

          return const WelcomeScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
