import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/error_views.dart';
import 'package:cop_belgium/widgets/fasting_history_card.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserFastingHistoryView extends StatefulWidget {
  static String userSavedPodcastView = 'userSavedPodcastView';

  const UserFastingHistoryView({Key? key}) : super(key: key);

  @override
  State<UserFastingHistoryView> createState() => _UserFastingHistoryViewState();
}

class _UserFastingHistoryViewState extends State<UserFastingHistoryView> {
  final _user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    //TODO: change
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
    return SafeArea(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .collection('fastingHistory')
            .orderBy('startDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return const NoFastingHistoryView();
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return TryAgainView(
              btnColor: isLoading ? kGrey : kYellowDark,
              onPressed: isLoading ? null : tryAgain,
            );
          }
          List<FastingInfo> allFastingInfo = [];

          final fastingDoc = snapshot.data!.docs;

          for (var doc in fastingDoc) {
            final fastingInfo = FastingInfo.fromMap(map: doc.data());

            if (fastingInfo.userId == FirebaseAuth.instance.currentUser!.uid) {
              allFastingInfo.add(fastingInfo);
            }
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: kBodyPadding,
              vertical: kBodyPadding,
            ),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 14),
            itemCount: allFastingInfo.length,
            itemBuilder: (context, index) {
              return FastingHistoryCard(
                fastingInfo: allFastingInfo[index],
              );
            },
          );
        },
      ),
    );
  }
}
