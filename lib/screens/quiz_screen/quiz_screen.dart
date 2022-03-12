import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kBackButton(context: context),
      ),
      body: const Center(
        child: Text(
          'Quiz Screen',
          style: kSFHeadLine1,
        ),
      ),
    );
  }
}
