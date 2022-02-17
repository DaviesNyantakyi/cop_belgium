import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_player_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_episode_card.dart';
import 'package:cop_belgium/providers/audio_provider.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PodcastDetailScreen extends StatefulWidget {
  static String podcastDetailScreen = 'podcastDetailScreen';
  const PodcastDetailScreen({Key? key}) : super(key: key);

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  bool bookMark = false;
  bool isLiked = false;
  Podcast? podcast;
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    setState(() {
      podcast = Provider.of<Podcast>(context, listen: false);
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
            const SizedBox(height: kButtonSpacing),
            _buildSubButton(),
            const SizedBox(height: kButtonSpacing),
            _buildDescription(),
            const SizedBox(height: kButtonSpacing),
            const Text('Episodes', style: kSFHeadLine3),
            const SizedBox(height: 16),
            const _BuildPodcastsList(),
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
        Expanded(
          child: Container(
            height: 190,
            width: 170,
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
          ),
        ),
        const SizedBox(width: kTextFieldSpacing),
        Expanded(
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
        ),
      ],
    );
  }

  Widget _buildSubButton() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Buttons.buildOutlinedButton(
        context: context,
        child: Text(
          'Subscribe',
          style: kSFTextFieldStyle,
        ),
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

  Widget get _buildBookmarkIcon {
    String docRef = podcast!.pageLink;
    return TextButton(
      onPressed: () {},
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .collection('savedPodcasts')
            .where('id', isEqualTo: docRef)
            .snapshots(),
        builder: (context, snapshot) {
          final docs = snapshot.data?.docs ?? [];
          if (docs.isNotEmpty) {
            //user has saved to podcast
            return const Icon(
              Icons.bookmark,
              color: kBlack,
            );
          }
          return const Icon(
            Icons.bookmark,
            color: kBlack,
          );
        },
      ),
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
      {required BuildContext context, required Podcast? podcast}) {
    return showNormalBottomSheet(
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

class _BuildPodcastsList extends StatelessWidget {
  const _BuildPodcastsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Episode> episodes = [
      Episode(
        image:
            'https://media.redcircle.com/images/2022/1/25/14/e6063a80-bb4f-444f-88bc-74d6363f7fad_09d7c-d7f5-48f4-af61-802673f35db0_pp_1400x1400.jpg',
        title: 'Deception',
        author: 'Church of Pentecos Belgium',
        description: '''What is going on in the end times.''',
        audio:
            'https://stream.redcircle.com/episodes/58ea3c7d-2079-4ed3-bc0d-19e507486d3d/stream.mp3',
        duration: const Duration(seconds: 1404),
        date: DateTime.now(),
      ),
    ];
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: kCardSpacing,
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
                        Provider<Episode>.value(
                          value: episodes[index],
                        ),
                        ChangeNotifierProvider<AudioProvider>.value(
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
