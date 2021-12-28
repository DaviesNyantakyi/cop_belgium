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
      child: Padding(
        padding: const EdgeInsets.only(bottom: kBodyBottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(),
                  const SizedBox(height: 20),
                  const Text(
                    'Latest Release',
                    style: kSFCaptionBold,
                  ),
                  const SizedBox(height: 16),
                  const SkeletonItem(child: LatestReleaseCard())
                ],
              ),
            ),
            const SizedBox(height: 42),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
              child: _buildSeriesTitle(),
            ),
            const SizedBox(height: 16),
            SkeletonItem(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: 15,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
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

  Widget _buildSeriesTitle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Podcasts',
              style: kSFCaptionBold,
            ),
            TextButton(
              child: const Text(
                'See All',
                style: kSFSubtitle2,
              ),
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
