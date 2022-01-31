import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_player_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_card.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_episode_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:dart_date/dart_date.dart';
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

class _BuildPodcastsList extends StatelessWidget {
  const _BuildPodcastsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Episode> podcast = [
      Episode(
        image:
            'https://media.redcircle.com/images/2022/1/20/9/0f91ce01-fc7e-4f17-9e8d-134ffd971764_3bbc32945_50d6bb29-3378-4b2c-bf15-73b9850bcffa.jpg',
        title: 'Don\'t Drag Your Sin Along',
        author: 'Amonie Akens & Elijah Wilson',
        description:
            '''The title is straightforward, yet so many of us literally drag our sin along anyway. Today, we dive into what the bible says this is and what it suggests about it.''',
        audio:
            'https://stream.redcircle.com/episodes/76f8d881-fa3e-49e7-a45b-c1e68850cea9/stream.mp3',
        duration: 3755,
        date: DateTime.now(),
      ),
      Episode(
        image:
            'https://images.rss.com/thezapatistaspodcast/400/20210706_114021_9ee273b1554e7b193a5379c082173f93.jpg',
        title: 'Episode 5: Community Media',
        author: 'Media',
        description:
            '''In this episode, Nancy Serano speaks with Ana Hernandez and Mario Najera from Promedios Mexico/Promedios Community Media. Promedios Mexico is a community media collective that has worked for over two decades with the Zapatistas, the Mexican revolutionary indigenous movement that governs many autonomous zones in Chiapas, Mexico. The Zapatistas' produce their own independent media within their own communities and in their own languages. By using community media, they document human rights violations, share ancestral knowledge, and promote modern technologies and practices. Their messaging goes beyond traditional political framings of struggles and instead includes creative and playful elements such as indigenous mythology and story-telling. This episode tells the story of how independent media became a powerful tool of resistance, independence, learning and sharing for the Zapatistas and it aims at inspiring communities and grassroots movements in Ireland and elsewhere.Links:https://web.facebook.com/F%C3%A1ilte-go-h%C3%89irinn-Zapatistas-2021-101658158954082https://promedioschiapas.wordpress.com/https://www.facebook.com/promedios.decomunicacioncomunitariahttps://radiozapatista.org/?lang=enhttps://www.facebook.com/RadioZapaVideos:The land belongs to those who work it. https://www.youtube.com/watch?v=PJf4FGP4jBMCorazon del Tiempo / Heart of Time (Spanish only)https://www.youtube.com/watch?v=taHoxs1xcrAVotan Kop -Documentary about Promedios Communication Projecthttps://www.youtube.com/watch?v=0UPhx3t1k0kPromedios Youtube Channelhttps://www.youtube.com/user/PromediosMexico/videosSongs:Cancion para los Caracoles del EZLN , Erick de JesusBegi Estalitako Indioa, SaggaroiRadios Comunitarios Zapatistas, unknown Zapatista bandLa Tierra (Corazon del Tiempo Soundtrack), Descemer BuenoText:The Story of the Calendar; Stories of Don Antonio, Subcomandante Insurgente MarcosImage:Beatriz Aurora''',
        audio:
            'https://media.rss.com/thezapatistaspodcast/20210814_103612_d1bccb48c8a65836b3ac4525af598290.mp3',
        duration: 3227,
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
                builder: (context) => Provider<Episode>.value(
                  value: podcast[index],
                  child: const PodcastPlayerScreen(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
