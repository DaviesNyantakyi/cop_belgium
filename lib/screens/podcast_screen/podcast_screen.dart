import 'package:cop_belgium/screens/announcement_screen/announcement.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_detail_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_series_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      appBar: _buildAppbar(),
      body: const SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: _BuildBody(),
        ),
      ),
    );
  }

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
              Navigator.pushNamed(
                  context, AnnouncementScreen.announcementScreen);
            },
          ),
        ),
      ],
    );
  }
}

class _BuildBody extends StatefulWidget {
  const _BuildBody({Key? key}) : super(key: key);

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  /* final List<PodcastSeriesCard> _series = const [
    //create a model with the podcast details not the cards
  ];*/

  @override
  Widget build(BuildContext context) {
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
                  _buildGreeting(userName: 'Sophia Smith'),
                  const SizedBox(height: 20),
                  _buildReleaseTitle(),
                  const SizedBox(height: 16),
                  _buildLatestCard(),
                ],
              ),
            ),
            const SizedBox(height: 42),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
              child: _buildSeriesTitle(
                text: 'Series',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            _buildSeriesList(),
          ],
        ),
      ),
    );
  }

  SizedBox _buildSeriesList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: 15,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: kBodyPadding),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: PodcastSeriesCard(
              image: 'assets/images/Rectangle 269.png',
              episodes: 12,
              title: 'The Paradigm',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PodcastDetailScreen.podcastDetailScreen,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

Widget _buildGreeting({required String userName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Good morning,',
        style: kSFBody,
      ),
      Row(
        children: [
          Text(
            userName,
            style: kSFHeadLine2.copyWith(color: kYellow),
          ),
          const SizedBox(width: 6),
          Image.asset('assets/images/icons/smile.png'),
        ],
      ),
    ],
  );
}

Widget _buildSeriesTitle({required String text, required VoidCallback onTap}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: kSFCaption,
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

Widget _buildReleaseTitle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text(
        'Latest Release',
        style: kSFCaption,
      ),
    ],
  );
}

Widget _buildLatestCard() {
  return Container(
    //background image
    width: 380,
    height: 180,
    decoration: const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/Rectangle 269.png'),
      ),
    ),
    child: TextButton(
      onPressed: () {},
      style: kTextButtonStyle,
      child: Container(
        //gradient
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              kBlueDark.withOpacity(1),
              kBlueDark.withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          // content
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 23)
                  .copyWith(left: 22, right: 89),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'The Paradigm',
                    style: kSFHeadLine2.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'What do we do with the passages in the Bible that are really difficult? What do we do with the passages in the Bible that are really difficult? ',
                    style: kSFBody.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  _buildPlayBt()
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildPlayBt() {
  return SizedBox(
    height: 40,
    width: 121,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.white,
        ),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
      onPressed: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Play Now',
            style: kSFBody.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          const Flexible(
            child: Icon(
              FontAwesomeIcons.chevronRight,
              size: 16,
              color: kBlueDark,
            ),
          ),
        ],
      ),
    ),
  );
}
