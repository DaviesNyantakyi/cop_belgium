import 'package:cop_belgium/screens/podcast_screen/podcast_detail_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            return PodcastCard(
              image: 'assets/images/Rectangle 269.png',
              title: 'Connecting the world in the most effective way possible',
              episodes: 2,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PodcastDetailScreen.podcastDetailScreen,
                );
              },
            );
          },
        ),
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

/*PodcastCard(
            image: 'assets/images/Rectangle 269.png',
            title: 'Connecting the world in the most effective way possible',
            episodes: 2,
          ),*/ 