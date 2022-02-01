import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/announcements_screen/announcements_screen.dart';
import 'package:cop_belgium/utilities/greeting.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/screens/all_screens.dart';

import 'package:provider/provider.dart';

const imagePlayHolder =
    'https://images.unsplash.com/photo-1614102073832-030967418971?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80';

class PodcastScreen extends StatefulWidget {
  static String podcastScreen = 'podcastScreen';
  const PodcastScreen({Key? key}) : super(key: key);

  @override
  _PodcastScreenState createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  TextEditingController rssLinkCntlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: kBodyPadding),
          child: FittedBox(
            child: Text(
              'Podcasts',
              style: kSFHeadLine2,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
        leadingWidth: 130,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: kBodyPadding, bottom: 25),
            child: TextButton(
              style: kTextButtonStyle,
              child: const Icon(
                Icons.notifications_outlined,
                color: kBlack,
                size: kIconSize,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AnnouncementsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_outlined),
        onPressed: () {
          _addPodcastDialog();
        },
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kBodyPadding),
          child: _Body(),
        ),
      ),
    );
  }

  Future<String?> _addPodcastDialog() async {
    const String _deleteConformationText = 'Copy and paste the RSS feed here.';
    return await showDialog<String?>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
        ),
        title: const Text(_deleteConformationText, style: kSFBodyBold),
        content: MyTextField(
          controller: rssLinkCntlr,
          hintText: 'RSS feed link',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: kSFBodyBold),
          ),
          const SizedBox(height: kButtonSpacing),
          TextButton(
            onPressed: () => {},
            child: const Text('OK', style: kSFBodyBold),
          ),
          const SizedBox(height: kTextFieldSpacing)
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _BuildGreeting(),
        SizedBox(height: 30),
        Text('Featured Episode', style: kSFHeadLine3),
        SizedBox(height: 15),
        _BuildLatestEpisodeCard(),
        SizedBox(height: 25),
        Text('Podcasts', style: kSFHeadLine3),
        SizedBox(height: 16),
        _BuildPodcastsList()
      ],
    );
  }
}

class _BuildGreeting extends StatelessWidget {
  const _BuildGreeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userName = FirebaseAuth.instance.currentUser?.displayName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Greeting.showGreetings(),
          style: kSFHeadLine3.copyWith(color: kBlue),
        ),
        Text(
          userName ?? '',
          style: kSFBody,
        ),
      ],
    );
  }
}

class _BuildPodcastsList extends StatelessWidget {
  const _BuildPodcastsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Podcast> podcast = [
      Podcast(
        title: 'Deeper Waters',
        author: 'Amonie Akens & Elijah Wilson',
        imageUrl:
            'https://media.redcircle.com/images/2021/9/27/20/ffe841f6-dba3-4e5e-b19e-363b036a3ecf_cc6f0f04-6416-49b8-9bdf-2dbad7238e93_blob.jpg',
        description:
            '''The creators of Pescados Bros, Amonie Akens & Elijah Wilson are here to dive deep into the word of God to help us become better disciples. Fulfilling the call in Matthew 4:19 to be fishers of men, we strive to present the complexities of the Bible in a form that's a bit easier to digest. Essentially, this podcast is a Gen Z Bible study designed to equip young disciples and create new disciples.''',
        pageLink: '',
        episodes: [],
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
        return PodcastCard(
          podcast: podcast[index],
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => Provider<Podcast>.value(
                  value: podcast[index],
                  child: const PodcastDetailScreen(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _BuildLatestEpisodeCard extends StatelessWidget {
  const _BuildLatestEpisodeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 189,
      decoration: BoxDecoration(
        color: kBlack,
        borderRadius: const BorderRadius.all(
          Radius.circular(kCardRadius),
        ),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(imagePlayHolder),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const PodcastPlayerScreen(),
            ),
          );
        },
        style: kTextButtonStyle,
        child: Container(
          width: 380,
          height: 190,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.1),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kCardContentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Deep Truths',
                  style: kSFHeadLine2.copyWith(color: kWhite),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  '''The aim of this Podcast is to bring individuals a better understanding of some of the deeper aspects of the gospel, brining greater hope. The aim of this Podcast is to bring individuals a better understanding of some of the deeper aspects of the gospel,''',
                  style: kSFBody.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: _BuildPlayButton(onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const PodcastPlayerScreen(),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildPlayButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _BuildPlayButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 125,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                'Play Now',
                style: kSFBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Expanded(
              child: Icon(
                Icons.play_arrow_outlined,
                size: 16,
                color: kBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
