import 'package:cop_belgium/screens/podcast_screen/widgets/latest_release_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
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
            children: const [
              Text(
                'Featured episode',
                style: kSFCaptionBold,
              ),
              SizedBox(height: 16),
              SkeletonItem(child: LatestReleaseCardSkeleton())
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
          child: _buildSeriesList(),
        ),
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
        mainAxisExtent: 200,
      ),
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
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
