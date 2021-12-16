import 'package:cop_belgium/screens/fasting_screen/fasting_history_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/fasting_history_card.dart';
import 'package:flutter/material.dart';

class UserFastingHistoryView extends StatelessWidget {
  static String userFastingHistoryView = 'userFastingHistoryView';

  const UserFastingHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: kBodyPadding, vertical: kBodyPadding),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FastingHistoryCard(
              startDate: '29 Dec 2021',
              endDate: '1 Jan 2021',
              duration: 200,
            ),
          );
        },
      ),
    );
  }
}
