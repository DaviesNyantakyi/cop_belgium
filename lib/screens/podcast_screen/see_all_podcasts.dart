import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_card.dart';
import 'package:cop_belgium/services/podcast_rss_handler.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletons/skeletons.dart';
/*
class SeeAllPodCastScreen extends StatefulWidget {
  static String seeAllPodCastScreen = 'seeAllPodCastScreen';
  const SeeAllPodCastScreen({Key? key}) : super(key: key);

  @override
  _SeeAllPodCastScreenState createState() => _SeeAllPodCastScreenState();
}

class _SeeAllPodCastScreenState extends State<SeeAllPodCastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context: context),
      body: SafeArea(
        child: FutureBuilder<Object>(
          future: PodcastRssHandler().getPodcastRss(
              rssLink:
                  'https://feeds.redcircle.com/cc66bbb2-1317-4712-b52e-28c52854a8a0'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _podcastCardSkeleton();
            }

            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('OOops', style: kSFHeadLine1),
                    const Text('Something went wrong.', style: kSFBody),
                    const SizedBox(height: 30),
                    Buttons.buildBtn(
                      context: context,
                      btnText: 'Try again',
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            }
            return GridView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(kBodyPadding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                childAspectRatio: 1 / 1,
              ),
              itemBuilder: (context, index) {
                return const PodcastCard();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _podcastCardSkeleton() {
    return SkeletonItem(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(kBodyPadding),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 15,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          childAspectRatio: 1 / 1,
        ),
        itemBuilder: (context, index) {
          return const PodcastCard();
        },
      ),
    );
  }

  dynamic buildAppbar({required BuildContext context}) {
    return AppBar(
      title: const Text('Podcasts', style: kSFCaptionBold),
      leading: Container(
        margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: kBlueDark,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

*/