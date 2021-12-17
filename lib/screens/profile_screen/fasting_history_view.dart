import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/fasting_history_card.dart';
import 'package:flutter/material.dart';

class UserFastingHistoryView extends StatefulWidget {
  static String userFastingHistoryView = 'userFastingHistoryView';

  const UserFastingHistoryView({Key? key}) : super(key: key);

  @override
  State<UserFastingHistoryView> createState() => _UserFastingHistoryViewState();
}

class _UserFastingHistoryViewState extends State<UserFastingHistoryView> {
  String startDate = '29 Dec 2021';

  String endDate = '1 Jan 2021';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: kBodyPadding, vertical: kBodyPadding),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: FastingHistoryCard(
              startDate: startDate,
              endDate: endDate,
              duration: 200,
            ),
          );
        },
      ),
    );
  }
}
