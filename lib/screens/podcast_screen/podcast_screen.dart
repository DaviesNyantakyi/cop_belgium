import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/announcements_screen/announcements_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_screen_skeletons.dart';
import 'package:cop_belgium/services/podcast_handlre.dart';
import 'package:cop_belgium/utilities/greeting.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/latest_release_card.dart';
import 'package:cop_belgium/widgets/error_views.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: kBlueDark,
          onRefresh: () async {
            await Provider.of<PodcastHandler>(context, listen: false)
                .getPodcasts();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: kBodyPadding),
            physics: const AlwaysScrollableScrollPhysics(),
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    List<Podcast> podcasts = [];

    bool hasError = Provider.of<PodcastHandler>(context).hasError;
    bool isLoading = Provider.of<PodcastHandler>(context).isLoading;
    podcasts = Provider.of<PodcastHandler>(context).podcasts;
    if (hasError) {
      return _buildErrorSkeleton();
    }

    if (isLoading) {
      return const PodcastScreenSkeleton();
    }

    if (podcasts.isEmpty) {
      return _buildNoPodcastsSkeleton();
    }

    return Provider.value(
      value: podcasts,
      child: const _Body(),
    );
  }

  Widget _buildNoPodcastsSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kBodyPadding,
        vertical: kBodyPadding,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: NoPodcastsView(
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildErrorSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kBodyPadding,
        vertical: kBodyPadding,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: TryAgainView(
          onPressed: () async {
            try {
              await Provider.of<PodcastHandler>(context, listen: false)
                  .getPodcasts();
            } on FirebaseException catch (e) {
              kshowSnackbar(
                context: context,
                errorType: 'error',
                text: e.message.toString(),
              );
            } catch (e) {
              debugPrint(e.toString());
            }
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var podcats = Provider.of<List<Podcast>>(context, listen: false);
    return Provider.value(
      value: podcats,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                Provider.value(
                  value: podcats,
                  child: const FeaturedReleaseCard(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kBodyPadding),
            child: Text(
              'Podcasts',
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          _buildSeriesList(),
        ],
      ),
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
    return Consumer<List<Podcast>>(builder: (context, podcasts, _) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          mainAxisExtent: 200,
        ),
        itemCount: podcasts.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
        itemBuilder: (context, index) {
          return PodcastCard(
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
          );
        },
      );
    });
  }
}
