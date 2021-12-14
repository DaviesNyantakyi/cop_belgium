import 'package:flutter/material.dart';

class UserFastingView extends StatelessWidget {
  static String userFastingView = 'userFastingView';

  const UserFastingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Fasting History'),
      ),
    );
  }
}
