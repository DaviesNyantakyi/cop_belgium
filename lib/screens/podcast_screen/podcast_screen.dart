import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_screen_skeletons.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/greeting.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/latest_release_card.dart';
import 'package:cop_belgium/services/podcast_rss_handler.dart';
import 'package:cop_belgium/widgets/error_views.dart';
import 'package:provider/provider.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class PodcastScreen extends StatefulWidget {
  static String podcastScreen = 'podcastScreen';
  const PodcastScreen({Key? key}) : super(key: key);

  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('podcasts')
        .snapshots()
        .listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: kBlueDark,
          onRefresh: () async {
            await PodcastRssHandler().getPodcast();
            if (mounted) {
              setState(() {});
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: kBodyPadding),
            physics: const AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<List<Podcast>>(
              future: PodcastRssHandler().getPodcast(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  if (snapshot.data!.isEmpty) {
                    return _buildNoPodcastsSkeleton();
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const PodcastScreenSkeleton();
                }

                if (snapshot.hasError) {
                  return _buildErrorSkeleton();
                }

                return Provider.value(
                  value: snapshot.data,
                  child: const _BuildBody(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoPodcastsSkeleton() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: kBodyBottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(),
                  const SizedBox(height: 40),
                  NoPodcastsView(
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
                  TryAgainView(
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
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var podcats = Provider.of<List<Podcast>>(context, listen: false);
    return Provider.value(
      value: podcats,
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
                Provider.value(
                  value: podcats,
                  child: const FeaturedReleaseCard(),
                ),
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
          _buildSeriesList(),
        ],
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
            _auth.currentUser!.displayName.toString(),
            style: kSFHeadLine2.copyWith(color: kYellow),
          ),
          const SizedBox(width: 6),
          Image.asset('assets/images/icons/smile.png'),
        ],
      ),
    ],
  );
}
