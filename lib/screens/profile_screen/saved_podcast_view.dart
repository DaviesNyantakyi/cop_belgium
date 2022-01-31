import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: kBodyPadding,
        horizontal: kBodyPadding,
      ),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        mainAxisExtent: 220,
      ),
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
