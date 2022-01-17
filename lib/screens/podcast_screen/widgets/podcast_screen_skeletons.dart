import 'package:cop_belgium/screens/announcements_screen/announcements_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/latest_release_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/greeting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletons/skeletons.dart';

class PodcastCardSkeleton extends StatelessWidget {
  const PodcastCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      decoration: const BoxDecoration(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingAndIcon(context: context),
              const SizedBox(height: 20),
              const Text(
                'Featured Episode',
                style: kSFHeadLine2,
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
            style: kSFHeadLine2,
          ),
        ),
        const SizedBox(height: 16),
        SkeletonItem(
          child: _buildSeriesList(),
        ),
      ],
    );
  }

  Widget _buildGreetingAndIcon({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Greeting.showGreetings(),
              style: kSFBody,
            ),
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? ' ',
              style: kSFHeadLine2.copyWith(color: kYellowDark, fontSize: 20),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.bell),
          tooltip: 'Announcements',
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AnnouncementsScreen(),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildSeriesList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
      ),
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              width: 170,
              height: 170,
              decoration: const BoxDecoration(
                color: kBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ],
        );
      },
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
              color: kBlue,
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
