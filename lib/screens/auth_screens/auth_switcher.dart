import 'package:cop_belgium/screens/auth_screens/welcome_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cop_belgium/screens/all_screens.dart';

class AuthSwitcher extends StatefulWidget {
  static String authScreenSwitcher = 'authScreenSwitcher';
  const AuthSwitcher({Key? key}) : super(key: key);

  @override
  _AuthSwitcherState createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<AuthSwitcher> {
  FirebaseAuth auth = FirebaseAuth.instance;

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
              child: kProgressIndicator,
            ),
          );
        }
      },
    );
  }
}
