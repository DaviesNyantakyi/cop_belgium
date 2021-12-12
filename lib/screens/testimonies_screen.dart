import 'package:flutter/material.dart';

class TestimoniesScreen extends StatelessWidget {
  static String testimoniesScreen = 'testimoniesScreen';
  const TestimoniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Tesitmonies Screen'),
        ),
      ),
    );
  }
}
