import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_player_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_episode_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PodcastDetailScreen extends StatefulWidget {
  static String podcastDetailScreen = 'podcastDetailScreen';
  const PodcastDetailScreen({Key? key}) : super(key: key);

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  String speaker =
      'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60';

  bool bookMark = false;
  bool isLiked = false;
  Podcast? podcast;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      podcast = Provider.of<Podcast>(context, listen: false);
    });

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
                    const SizedBox(height: 30),
                    // const SizedBox(height: 32),
                  ],
                ),
              ),
              // _buildSpeakers(),
              // const SizedBox(height: 36),
              _buildEpisodesList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    if (podcast?.image != null) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          color: kBlue,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(podcast!.image),
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
            itemCount: podcast?.episodes!.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: kBodyPadding),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Provider.value(
                  value: podcast!.episodes![index],
                  child: PodcastEpisodesCard(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Provider.value(
                            value: podcast!.episodes![index],
                            child: const PodcastPlayerScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

/*
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
*/
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
            backgroundImage: NetworkImage(speaker),
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
          child: Text(
            podcast?.title ?? '',
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
        TextButton(
          style: kTextButtonStyle,
          onPressed: () {
            _showBottomSheet(
                context: context,
                title: podcast?.title ?? '',
                description: podcast?.description ?? '');
          },
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              podcast?.description ?? '',
              style: kSFBody,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
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
              FormalDates.formatDmy(date: podcast!.episodes!.last.date),
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
              const Text(
                'likes',
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

  Future<void> _showBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    return showMyBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }
}
