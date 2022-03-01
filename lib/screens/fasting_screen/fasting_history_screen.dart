import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/error_views.dart';
import 'package:cop_belgium/widgets/fasting_history_card.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FastingHistoryScreen extends StatefulWidget {
  static String fastingHistoryScreen = 'fastingHistoryScreen';

  const FastingHistoryScreen({Key? key}) : super(key: key);

  @override
  _FastingHistoryScreenState createState() => _FastingHistoryScreenState();
}

class _FastingHistoryScreenState extends State<FastingHistoryScreen> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

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
        type: 'error',
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
    return Scaffold(
      appBar: _buildAppbar(),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser!.uid)
              .collection('fastingHistory')
              .orderBy('startDate', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/no_fast_added.png',
                        height: 220,
                        width: 220,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'No fasting history',
                        style: kSFBody,
                      ),
                    ],
                  ),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError) {
              return TryAgainView(
                btnColor: isLoading ? kGrey : kBlue,
                onPressed: isLoading ? null : tryAgain,
              );
            }
            List<FastingInfo> allFastingInfo = [];

            final fastingDoc = snapshot.data!.docs;

            for (var doc in fastingDoc) {
              final fastingInfo = FastingInfo.fromMap(map: doc.data());

              if (fastingInfo.userId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                allFastingInfo.add(fastingInfo);
              }
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: kBodyPadding,
                vertical: kBodyPadding,
              ),
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
      ),
    );
  }

  dynamic _buildAppbar() {
    return AppBar(
      elevation: 1,
      title: const Text(
        'Fasting History',
        style: kSFHeadLine3,
      ),
      leading: TextButton(
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: kAppbarPadding),
          child: Icon(
            Icons.chevron_left_outlined,
            color: kBlack,
            size: 35,
          ),
        ),
        onPressed: () {
          Navigator.of(context)
            ..pop()
            ..pop();
        },
        style: kTextButtonStyle,
      ),
    );
  }
}
