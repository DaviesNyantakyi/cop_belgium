import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_player_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_episode_card.dart';
import 'package:cop_belgium/utilities/audio_provider.dart';
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
            const SizedBox(height: kTextFieldSpacing),
            _buildSubButton(),
            const SizedBox(height: 32),
            _buildDescription(),
            const SizedBox(height: 19),
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
        Container(
          height: 170,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(kCardRadius),
            ),
            color: kBlue,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(podcast!.imageUrl),
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
                style: kSFHeadLine3,
              ),
              const SizedBox(height: 5),
              Text(podcast?.author ?? ''),
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
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'About',
            style: kSFBodyBold,
          ),
        ),
        const SizedBox(height: 12),
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
    return showBottomSheet1(
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
    List<Episode> podcast = [
      Episode(
        image:
            'https://media.redcircle.com/images/2022/1/31/4/22c2af0a-445b-439f-9388-8fd3dd617d09_973f7793-8ee2-459a-905c-317a3e32abfb.jpg',
        title: 'Don\'t Drag Your Sin Along',
        author: 'Amonie Akens & Elijah Wilson',
        description:
            '''The title is straightforward, yet so many of us literally drag our sin along anyway. Today, we dive into what the bible says this is and what it suggests about it.''',
        audio:
            'https://stream.redcircle.com/episodes/2e495e6f-825c-4320-8661-6b44938712f7/stream.mp3',
        duration: const Duration(seconds: 3755),
        date: DateTime.now(),
      ),
    ];
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: kCardSpacing,
      ),
      itemCount: podcast.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return EpisodeCard(
          episode: podcast[index],
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<AudioProvider>(
                  create: (context) => AudioProvider(),
                  child: Provider<Episode>.value(
                    value: podcast[index],
                    child: const PodcastPlayerScreen(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
