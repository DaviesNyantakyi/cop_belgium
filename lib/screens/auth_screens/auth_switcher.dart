import 'package:cop_belgium/services/podcast_handlre.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cop_belgium/screens/all_screens.dart';

import 'package:provider/provider.dart';

class AuthSwitcher extends StatefulWidget {
  static String authScreenSwitcher = 'authScreenSwitcher';
  const AuthSwitcher({Key? key}) : super(key: key);

  @override
  _AuthSwitcherState createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher> {
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await checkConnnection();

   

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
