import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/providers/audio_provider.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_detail_screen.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class SavedPodcastView extends StatefulWidget {
  static String userSavedPodcastView = 'userSavedPodcastView';

  const SavedPodcastView({Key? key}) : super(key: key);

  @override
  State<SavedPodcastView> createState() => _SavedPodcastViewState();
}

class _SavedPodcastViewState extends State<SavedPodcastView> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  List<Podcast> podcast = [
    Podcast(
      title: 'Deep Truths',
      author: 'Church of Pentecost Belgium',
      imageUrl:
          'https://media.redcircle.com/images/2022/1/25/14/e6063a80-bb4f-444f-88bc-74d6363f7fad_09d7c-d7f5-48f4-af61-802673f35db0_pp_1400x1400.jpg',
      description:
          '''Welcome to the Pentecostal Church podcast! Here we dive and discover the deep truth from the Scriptures.''',
      pageLink: '',
      episodes: [],
    ),
  ];

  Future<void> tryAgain() async {
    try {
      isLoading = true;
      if (mounted) {
        setState(() {});
      }
      EasyLoading.show();
    } on FirebaseException catch (e) {
      kshowSnackbar(
        context: context,
        type: SnackBarType.error,
        text: e.message.toString(),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
      isLoading = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(
                  horizontal: kBodyPadding, vertical: kBodyPadding)
              .copyWith(top: 20),
          separatorBuilder: (context, index) => const SizedBox(
            height: kContentSpacing12,
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
                    builder: (context) => MultiProvider(
                      providers: [
                        Provider<Podcast>.value(
                          value: podcast[index],
                        ),
                        ChangeNotifierProvider<AudioProvider>.value(
                          value: audioProvider,
                        ),
                      ],
                      child: const PodcastDetailScreen(),
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
