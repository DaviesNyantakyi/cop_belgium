import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static String settingsScreen = 'settingsScreen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: Center(
          child: Text('settings'),
        ),
      ),
    );
  }
}
