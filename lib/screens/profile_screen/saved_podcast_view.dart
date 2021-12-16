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


/*GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: 150,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const PodcastSeriesCard(
          image: 'assets/images/Rectangle 269.png',
          title: 'Why did eve ',
          episodes: 12,
        );
      },
    );*/