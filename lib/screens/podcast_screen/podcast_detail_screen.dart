import 'package:cop_belgium/screens/podcast_screen/play_podcast_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_episode_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

String _profileImage =
    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';
String _text =
    '''What do we do with the passages in the Bible that are really difficult? Violence, slavery, the treatment of women—what the Bible has to say about these topics has, at times, been misinterpreted and misused. ''';

class PodcastDetailScreen extends StatelessWidget {
  static String podcastDetailScreen = 'podcastDetailScreen';
  const PodcastDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: kBodyPadding),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kBodyPadding,
                    vertical: kBodyPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 32),
                      _buildDescription(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                _buildSpeakers(),
                const SizedBox(height: 36),
                _buildEpisodes(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildEpisodes() {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(left: kBodyPadding),
        alignment: Alignment.centerLeft,
        child: const Text('Episodes', style: kSFCaption),
      ),
      const SizedBox(height: 12),
      _buildSeriesList(),
    ],
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
          child: PodcastEpisodesCard(
            image: 'assets/images/Rectangle 269.png',
            episodes: 12,
            title: 'Humans are Trees?',
            onTap: () {
              Navigator.pushNamed(context, PlayPodcastScreen.playPodcastScreen);
            },
          ),
        );
      },
    ),
  );
}

Widget _buildSpeakers() {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(left: kBodyPadding),
        alignment: Alignment.centerLeft,
        child: const Text('Speakers', style: kSFCaption),
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 73,
        child: ListView.builder(
          padding: const EdgeInsets.only(left: kBodyPadding),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                right: kBodyPadding,
              ),
              child: _buildAvatar(
                onTap: () {},
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget _buildAvatar({VoidCallback? onTap}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(_profileImage),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: kBlueLight.withOpacity(0.3),
                  onTap: onTap,
                ),
              ),
            ),
          )
        ],
      ),
      const SizedBox(height: 8),
      const Text('John Smith', style: kSFSubtitle2),
    ],
  );
}

Widget _buildTitle() {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          'Tree Of Life',
          style: kSFHeadLine1,
        ),
      ),
      const SizedBox(height: 12),
      _buildDetail(
        dateTime: 'December 6, 2021',
        likes: 250,
      ),
    ],
  );
}

Widget _buildDescription() {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          'Description',
          style: kSFCaption,
        ),
      ),
      const SizedBox(height: 12),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          _text,
          style: kSFBody,
        ),
      )
    ],
  );
}

Widget _buildDetail({
  required String dateTime,
  required int likes,
}) {
  return Row(
    children: [
      Row(
        children: [
          Image.asset(
            'assets/images/icons/calendar_icon.png',
            width: 16,
            height: 17,
          ),
          const SizedBox(width: 8),
          Text(
            dateTime,
            style: kSFBody,
          ),
        ],
      ),
      const SizedBox(width: 19),
      Row(
        children: [
          Image.asset(
            'assets/images/icons/hand_clap_icon.png',
            width: 16,
            height: 17,
          ),
          const SizedBox(width: 8),
          Text(
            '${likes}K',
            style: kSFBody,
          ),
        ],
      ),
    ],
  );
}

dynamic _buildAppbar({VoidCallback? onTap}) {
  return AppBar(
    leading: Container(
      margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
      child: InkWell(
        splashColor: kBlueLight,
        child: Image.asset(
          'assets/images/icons/arrow_left_icon.png',
        ),
        onTap: onTap,
      ),
    ),
  );
}
