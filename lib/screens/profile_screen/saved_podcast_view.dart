import 'package:cop_belgium/screens/podcast_screen/podcast_detail_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class UserSavedPodcastView extends StatelessWidget {
  static String userSavedPodcastView = 'userSavedPodcastView';

  const UserSavedPodcastView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: kBodyPadding,
        vertical: kBodyPadding,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return PodcastCard(
          image: 'assets/images/Rectangle 269.png',
          title: 'title',
          episodes: 12,
          onPressed: () {
            Navigator.pushNamed(
              context,
              PodcastDetailScreen.podcastDetailScreen,
            );
          },
        );
      },
    );
  }
}
