import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_screen_skeletons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cop_belgium/screens/announcement_screen/announcement_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/greeting.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/latest_release_card.dart';
import 'package:cop_belgium/services/podcast_rss_handler.dart';
import 'package:cop_belgium/widgets/try_again.dart';
import 'package:provider/provider.dart';

class PodcastScreen extends StatefulWidget {
  static String podcastScreen = 'podcastScreen';
  const PodcastScreen({Key? key}) : super(key: key);

  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic _buildAppbar() {
      return AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Icon(
                FontAwesomeIcons.bell,
                color: kBlueDark,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AnnouncementScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: _buildAppbar(),
      body: const SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: _BuildBody(),
        ),
      ),
    );
  }
}

class _BuildBody extends StatefulWidget {
  const _BuildBody({Key? key}) : super(key: key);

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Podcast>>(
      future: PodcastRssHandler().getPodcast(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PodcastScreenSkeleton();
        }

        if (snapshot.hasError) {
          return _buildErrorSkeleton();
        }

        return Provider.value(
          value: snapshot.data,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: kBodyBottomPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kBodyPadding),
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
                        const LatestReleaseCard()
                      ],
                    ),
                  ),
                  const SizedBox(height: 42),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kBodyPadding),
                    child: _buildSeriesTitle(),
                  ),
                  const SizedBox(height: 16),
                  _buildSeriesList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorSkeleton() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
                  const SizedBox(height: 40),
                  TryAgainButton(
                    onPressed: () {
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeriesList() {
    return Consumer<List<Podcast>>(builder: (context, podcasts, _) {
      return SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: podcasts.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: kBodyPadding),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: PodcastCard(
                podcast: podcasts[index],
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Provider.value(
                        value: podcasts[index],
                        child: const PodcastDetailScreen(),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildGreeting() {
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
              auth.currentUser!.displayName.toString(),
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
              onPressed: () {
                /*Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SeeAllPodCastScreen(),
                  ),
                );*/
              },
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
