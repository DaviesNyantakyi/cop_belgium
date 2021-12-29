import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cop_belgium/screens/all_screens.dart';
import 'package:provider/provider.dart';

class AuthScreenSwitcher extends StatefulWidget {
  static String authScreenSwitcher = 'authScreenSwitcher';
  const AuthScreenSwitcher({Key? key}) : super(key: key);

  @override
  _AuthScreenSwitcherState createState() => _AuthScreenSwitcherState();
}

class _AuthScreenSwitcherState extends State<AuthScreenSwitcher> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    checkConnnection();
  }

  void checkConnnection() {
    // check internet connection when the app starts
    Provider.of<ConnectionChecker>(context, listen: false)
        .intializeConnectionChecker();
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
