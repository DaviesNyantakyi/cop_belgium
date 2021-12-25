import 'package:cop_belgium/screens/podcast_screen/play_podcast_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_episode_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String _speaker =
    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';
String _description =
    '''What do we do with the passages in the Bible that are really difficult? Violence, slavery, the treatment of women—what the Bible has to say about these topics has, at times, been misinterpreted and misused. ''';

class PodcastDetailScreen extends StatefulWidget {
  static String podcastDetailScreen = 'podcastDetailScreen';
  const PodcastDetailScreen({Key? key}) : super(key: key);

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  bool bookMark = false;
  bool isLiked = false;
  String? dateTime = '2 Dec 2021';
  int? likes = 200;
  String? podcastImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: Padding(
        padding: const EdgeInsets.only(bottom: kBodyPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeaderImage(),
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
              _buildEpisodesList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    if (podcastImage != null) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          color: kBlue,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(podcastImage!),
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(
          color: kBlueDark,
        ),
      );
    }
  }

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: const BoxDecoration(
        color: kBlue,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/meeting.jpg'),
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }

  Column _buildEpisodesList() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: kBodyPadding),
          alignment: Alignment.centerLeft,
          child: const Text('Episodes', style: kSFCaptionBold),
        ),
        const SizedBox(height: 12),
        SizedBox(
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
                  image: 'assets/images/meeting.jpg',
                  title: 'Humans are Trees?',
                  length: '10:00',
                  date: '12 Dec 2021',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      PlayPodcastScreen.playPodcastScreen,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakers() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: kBodyPadding),
          alignment: Alignment.centerLeft,
          child: const Text('Speakers', style: kSFCaptionBold),
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
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(_speaker),
          ),
          const SizedBox(height: 8),
          const Text('John Smith', style: kSFSubtitle2),
        ],
      ),
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
        _buildDetail(),
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
            style: kSFCaptionBold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            _description,
            style: kSFBody,
          ),
        )
      ],
    );
  }

  Widget _buildDetail() {
    return Row(
      children: [
        Row(
          children: [
            const Icon(
              FontAwesomeIcons.calendar,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '$dateTime',
              style: kSFBody,
            ),
          ],
        ),
        const SizedBox(width: 19),
        TextButton(
          onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Row(
            children: [
              Icon(
                isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                color: kBlueDark,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '$likes',
                style: kSFBody,
              ),
            ],
          ),
        ),
        const SizedBox(width: 19),
        TextButton(
          style: kTextButtonStyle,
          child: Icon(
            bookMark == false
                ? FontAwesomeIcons.bookmark
                : FontAwesomeIcons.solidBookmark,
            size: 20,
            color: kBlueDark,
          ),
          onPressed: () {
            setState(() {
              bookMark = !bookMark;
            });
          },
        ),
      ],
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: TextButton(
        child: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: kBlueDark,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }
}
