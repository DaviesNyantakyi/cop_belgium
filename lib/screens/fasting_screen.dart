import 'package:flutter/material.dart';

class FastingScreens extends StatelessWidget {
  static String fastingScreens = 'fastingScreens';
  const FastingScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Fasting Screen'),
        ),
      ),
    );
  }
}
