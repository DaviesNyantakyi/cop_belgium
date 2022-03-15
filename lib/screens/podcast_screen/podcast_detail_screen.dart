import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/providers/audio_provider.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_player_screen.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/podcast_episode_card.dart';

class PodcastDetailScreen extends StatefulWidget {
  static String podcastDetailScreen = 'podcastDetailScreen';
  const PodcastDetailScreen({Key? key}) : super(key: key);

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  bool bookMark = false;
  bool isLiked = false;
  PodcastModel? podcast;

  @override
  Widget build(BuildContext context) {
    setState(() {
      podcast = Provider.of<PodcastModel>(context, listen: false);
    });

    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kBodyPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: kContentSpacing20),
            _buildSubscribeButton(),
            const SizedBox(height: kContentSpacing32),
            _buildDescription(),
            const SizedBox(height: kContentSpacing32),
            const Text('Episodes', style: kSFHeadLine3),
            const SizedBox(height: 16),
            const _BuildEpisodesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),
        const SizedBox(width: kContentSpacing12),
        _buildTitle(),
        const SizedBox(width: kContentSpacing12),
      ],
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            podcast?.title ?? ' ',
            style: podcast!.title.length > 40 ? kSFBodyBold : kSFHeadLine2,
          ),
          const SizedBox(height: 5),
          Text(
            podcast?.author ?? '',
            style: podcast!.title.length > 40 ? kSFBody2 : kSFBody,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(kCardRadius),
        ),
        color: kBlue,
        boxShadow: [kBoxShadow],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(podcast!.imageUrl),
        ),
      ),
    );
  }

  Widget _buildSubscribeButton() {
    return SizedBox(
      child: Buttons.buildOutlinedButton(
        width: 140,
        height: 40,
        context: context,
        child: const Text('Subscribe', style: kSFBody),
        onPressed: () {},
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      children: [
        TextButton(
          style: kTextButtonStyle,
          onPressed: () {
            _showBottomSheet(context: context, podcast: podcast);
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

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: TextButton(
        child: kBackButton(context: context),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }

  Future<void> _showBottomSheet(
      {required BuildContext context, required PodcastModel? podcast}) {
    return showMyBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              podcast?.title ?? '',
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              podcast?.description ?? '',
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildEpisodesList extends StatelessWidget {
  const _BuildEpisodesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<EpisodeModel> episodes = [
      EpisodeModel(
        image:
            'https://media.redcircle.com/images/2022/1/25/14/e6063a80-bb4f-444f-88bc-74d6363f7fad_09d7c-d7f5-48f4-af61-802673f35db0_pp_1400x1400.jpg',
        title: 'Deception',
        author: 'Church of Pentecos Belgium',
        description: '''What is going on in the end times.''',
        audioUrl:
            'https://stream.redcircle.com/episodes/58ea3c7d-2079-4ed3-bc0d-19e507486d3d/stream.mp3',
        duration: const Duration(seconds: 1404),
        date: DateTime.now(),
        podcastName: 'Deep Thruths',
        podcastUrl:
            'https://feeds.redcircle.com/ef5caef7-c00e-4dcf-9bac-90b60a2db406',
      ),
    ];
    return Consumer<AudioPlayerNotifier>(
      builder: (context, audioProvider, _) {
        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: kContentSpacing12,
          ),
          itemCount: episodes.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return EpisodeCard(
              episode: episodes[index],
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        Provider<EpisodeModel>.value(
                          value: episodes[index],
                        ),
                        ChangeNotifierProvider<AudioPlayerNotifier>.value(
                          value: audioProvider,
                        ),
                      ],
                      child: const PodcastPlayerScreen(),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
