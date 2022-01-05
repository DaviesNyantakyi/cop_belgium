import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_player_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_episode_card.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: kBodyPadding),
        child: SingleChildScrollView(
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
                  ],
                ),
              ),
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
          style: kTextButtonStyle,
          child: _buildBookmarkIcon(),
          onPressed: () async {
            await CloudFireStore().saveUnsavePodcast(
              rssInfo: PodcastRssInfo(
                id: podcast!.id,
                rssLink: podcast!.rssLink,
                title: podcast?.title ?? '',
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBookmarkIcon() {
    String docRef = podcast!.id;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
            FontAwesomeIcons.solidBookmark,
            size: 20,
            color: kBlueDark,
          );
        }
        return const Icon(
          FontAwesomeIcons.bookmark,
          size: 20,
          color: kBlueDark,
        );
      },
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
