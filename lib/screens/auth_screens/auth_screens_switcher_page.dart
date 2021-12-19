import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cop_belgium/screens/all_screens.dart';

class AuthScreenSwitcher extends StatefulWidget {
  static String authScreenSwitcher = 'authScreenSwitcher';
  const AuthScreenSwitcher({Key? key}) : super(key: key);

  @override
  _AuthScreenSwitcherState createState() => _AuthScreenSwitcherState();
}

class _AuthScreenSwitcherState extends State<AuthScreenSwitcher> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snaphot) {
        if (snaphot.connectionState == ConnectionState.active) {
          final user = snaphot.data;
          if (user == null) {
            return const WelcomeScreen();
          }

          return const BottomNavSelectorPage();
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
