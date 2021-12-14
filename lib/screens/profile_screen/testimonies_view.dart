import 'package:flutter/material.dart';

class UserTestimoniesView extends StatelessWidget {
  static String userTestimoniesView = 'userTestimoniesView';

  const UserTestimoniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('My testimonies'),
      ),
    );
  }
}
