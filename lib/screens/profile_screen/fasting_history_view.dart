import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/fasting_history_card.dart';

import 'package:flutter/material.dart';

class UserFastingHistoryView extends StatefulWidget {
  static String userSavedPodcastView = 'userSavedPodcastView';

  const UserFastingHistoryView({Key? key}) : super(key: key);

  @override
  State<UserFastingHistoryView> createState() => _UserFastingHistoryViewState();
}

class _UserFastingHistoryViewState extends State<UserFastingHistoryView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(kBodyPadding).copyWith(top: kBodyPadding),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: kContentSpacing12),
      itemCount: 5,
      itemBuilder: (context, index) {
        return FastingHistoryCard(
          fastingInfo: FastingInfo(
            duration: const Duration(hours: 20),
            type: 'custom',
            startDate: DateTime.now(),
            endDate: DateTime.now(),
            goalDate: DateTime.now(),
            note: 'hzkfjzk',
          ),
        );
      },
    );
  }
}
