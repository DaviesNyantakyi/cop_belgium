import 'package:cop_belgium/screens/podcast_screen/widgets/latest_release_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/greeting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PodcastCardSkeleton extends StatelessWidget {
  const PodcastCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      decoration: const BoxDecoration(
        color: kBlueLight, // card background color
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    );
  }
}

class PodcastScreenSkeleton extends StatelessWidget {
  const PodcastScreenSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreeting(),
                const SizedBox(height: 45),
                const Text(
                  'Featured episode',
                  style: kSFCaptionBold,
                ),
                const SizedBox(height: 16),
                const SkeletonItem(child: LatestReleaseCardSkeleton())
              ],
            ),
          ),
          const SizedBox(height: 42),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kBodyPadding),
            child: Text(
              'Podcasts',
              style: kSFCaptionBold,
            ),
          ),
          const SizedBox(height: 16),
          SkeletonItem(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 15,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(
                    parent: NeverScrollableScrollPhysics()),
                padding: const EdgeInsets.only(left: kBodyPadding),
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: PodcastCardSkeleton(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          YonoGreetings.showGreetings(),
          style: kSFBody,
        ),
        Row(
          children: [
            Text(
              user?.displayName ?? '',
              style: kSFHeadLine2.copyWith(color: kYellow),
            ),
            const SizedBox(width: 6),
            Image.asset('assets/images/icons/smile.png'),
          ],
        ),
      ],
    );
  }
}

class SavedPodcastScreenSkeleton extends StatelessWidget {
  const SavedPodcastScreenSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: kBodyPadding,
          horizontal: kBodyPadding,
        ),
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          mainAxisExtent: 200,
        ),
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            height: 200,
            decoration: const BoxDecoration(
              color: kBlueLight,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          );
        },
      ),
    );
  }
}
