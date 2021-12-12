import 'package:cop_belgium/utilities/colors.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:cop_belgium/widgets/podcast_card.dart';
import 'package:flutter/material.dart';

class PodcastScreen extends StatefulWidget {
  static String podcastScreen = 'podcastScreen';
  const PodcastScreen({Key? key}) : super(key: key);

  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
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
  final double _pagePadding = 20;
  final List<PodcastCard> _series = const [
    // this is the podcast information not the card
    // create a model
    PodcastCard(
      image: 'assets/images/Rectangle 269.png',
      episodes: 12,
      title: 'The Paradigm',
    ),
    PodcastCard(
      image: 'assets/images/Rectangle 269.png',
      episodes: 12,
      title: 'The Paradigm',
    ),
    PodcastCard(
      image: 'assets/images/Rectangle 269.png',
      episodes: 12,
      title: 'The Paradigm',
    ),
    PodcastCard(
      image: 'assets/images/Rectangle 269.png',
      episodes: 12,
      title: 'The Paradigm',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(userName: 'Sophia Smith'),
                  const SizedBox(height: 20),
                  _buildReleaseTitle(
                    onTap: () {
                      debugPrint('See all');
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildLatestCard(
                    title: 'The Paradigm',
                    description:
                        'What do we do with the passages in the Bible that are really difficult?',
                    image: const AssetImage('assets/images/Rectangle 269.png'),
                    onTap: () {
                      debugPrint('The Paradigm');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 42),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _pagePadding),
              child: _buildSeriesTitle(
                text: 'Series',
                onTap: () {
                  debugPrint('See all');
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildSeriesList(),
            const SizedBox(height: 42),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _pagePadding),
              child: _buildSeriesTitle(
                text: 'Most Popular Episodes',
                onTap: () {
                  debugPrint('See all');
                },
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
        itemCount: _series.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: _pagePadding),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _series[index],
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
        style: kSFNormal,
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
          InkWell(
            child: const Text(
              'See All',
              style: kSFSubtitle2,
            ),
            onTap: onTap,
          ),
        ],
      ),
    ],
  );
}

Widget _buildReleaseTitle({required VoidCallback onTap}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Latest Release',
            style: kSFCaption,
          ),
          InkWell(
            child: const Text(
              'See All',
              style: kSFSubtitle2,
            ),
            onTap: onTap,
          ),
        ],
      ),
    ],
  );
}

Widget _buildLatestCard({
  required String title,
  required String description,
  required ImageProvider image,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      //background image
      width: 380,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image,
        ),
      ),
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
                    style: kSFNormal.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  _buildPlayBt(
                    onPressed: onTap,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildPlayBt({VoidCallback? onPressed}) {
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
        shadowColor: MaterialStateProperty.all(
          kBlueLight,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Play Now',
            style: kSFNormal.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Image.asset(
              'assets/images/icons/arrow_right.png',
            ),
          ),
        ],
      ),
    ),
  );
}
