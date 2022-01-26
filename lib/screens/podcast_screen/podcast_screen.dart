import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/announcements_screen/announcements_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_screen_skeletons.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/services/podcast_provider.dart';
import 'package:cop_belgium/services/podcast_service.dart';
import 'package:cop_belgium/utilities/greeting.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/latest_release_card.dart';
import 'package:cop_belgium/widgets/error_views.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//TODO: show loading indicator when try again button is pressed
//TODO: Reduce getting podcasts time and try getting each podcast indiviualy

class PodcastScreen extends StatefulWidget {
  static String podcastScreen = 'podcastScreen';
  const PodcastScreen({Key? key}) : super(key: key);

  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  TextEditingController rssLinkCntlr = TextEditingController();
  bool isLoading = false;

  Future<void> tryAgain() async {
    try {
      isLoading = true;
      if (mounted) {
        setState(() {});
      }
      EasyLoading.show();
      await Provider.of<PodcastProvider>(context, listen: false).getPodcasts();
    } on FirebaseException catch (e) {
      kshowSnackbar(
        context: context,
        errorType: 'error',
        text: e.message.toString(),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
      isLoading = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> addPodcast() async {
    try {
      if (rssLinkCntlr.text.isNotEmpty) {
        EasyLoading.show();
        await CloudFireStore().addPodcast(rssLink: rssLinkCntlr.text);
        Navigator.pop(context);
        rssLinkCntlr.clear();
      }
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      kshowSnackbar(
        context: context,
        errorType: 'error',
        text: e.message!,
      );
      debugPrint(e.toString());
    } catch (e) {
      Navigator.pop(context);
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(FontAwesomeIcons.plus),
        onPressed: () {
          _showAddDialog();
        },
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: kBlueDark,
          onRefresh: () async {
            await Provider.of<PodcastProvider>(context, listen: false)
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

  Future<String?> _showAddDialog() async {
    const String _deleteConformationText = 'Copy and paste the RSS feed here.';
    return await showDialog<String?>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
        ),
        title: const Text(_deleteConformationText, style: kSFBodyBold),
        content: MyTextField(
          controller: rssLinkCntlr,
          hintText: 'RSS feed link',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: kSFBodyBold),
          ),
          const SizedBox(height: kButtonSpacing),
          TextButton(
            onPressed: addPodcast,
            child: const Text('OK', style: kSFBodyBold),
          ),
          const SizedBox(height: kTextFieldSpacing)
        ],
      ),
    );
  }

  Widget _buildBody() {
    List<Podcast> podcasts = [];

    bool hasError = Provider.of<PodcastProvider>(context).hasError;
    bool isLoading = Provider.of<PodcastProvider>(context).isLoading;
    podcasts = Provider.of<PodcastProvider>(context).podcasts;
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
          btnColor: isLoading ? kGrey : kYellowDark,
          onPressed: isLoading ? null : tryAgain,
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
                const SizedBox(height: 42),
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
    final userName = FirebaseAuth.instance.currentUser?.displayName;
    //TODO: Display name does not show after registrations

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Greeting.showGreetings(),
              style: kSFBodyBold,
            ),
            Text(
              userName ?? '',
              style: kSFBody.copyWith(color: Colors.yellow.shade900),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          child: IconButton(
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
          ),
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
          crossAxisCount: 2,
          mainAxisExtent: 220,
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
