import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/screens/podcast_screen/widgets/podcast_screen_skeletons.dart';
import 'package:cop_belgium/services/podcast_service.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/error_views.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class UserSavedPodcastView extends StatefulWidget {
  static String userSavedPodcastView = 'userSavedPodcastView';

  const UserSavedPodcastView({Key? key}) : super(key: key);

  @override
  State<UserSavedPodcastView> createState() => _UserSavedPodcastViewState();
}

class _UserSavedPodcastViewState extends State<UserSavedPodcastView> {
  final _user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .collection('savedPodcasts')
        .snapshots()
        .listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
  }

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
        errorType: 'error',
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
    return FutureBuilder<List<Podcast>>(
      future: PodcastService().getSavedPodcast(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return _buildNoSavedPodcastsSkeleton();
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SavedPodcastScreenSkeleton();
        }

        if (snapshot.hasError) {
          return _buildErrorSkeleton();
        }
        return GridView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: kBodyPadding,
            horizontal: kBodyPadding,
          ),
          itemCount: snapshot.data!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            mainAxisExtent: 220,
          ),
          itemBuilder: (context, index) {
            return PodcastCard(
              podcast: snapshot.data![index],
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Provider.value(
                      value: snapshot.data![index],
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

  Widget _buildErrorSkeleton() {
    return SingleChildScrollView(
      child: TryAgainView(
        btnColor: isLoading ? kGrey : kYellowDark,
        onPressed: isLoading ? null : tryAgain,
      ),
    );
  }

  Widget _buildNoSavedPodcastsSkeleton() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kBodyPadding),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NoSavedPodcastsView(
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
