import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/providers/image_selector_provider.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/church_selector.dart';
import 'package:cop_belgium/widgets/easy_loading.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  bool isLoading = false;

  late final ImageSelectorProvider imageSelector;

  TextStyle fontStyle = kSFBody;

  Future<void> submit() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      await EaslyLoadingIndicator.showLoading();

      // await FireStorage().uploadProfileImage(image: image);

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      await EaslyLoadingIndicator.dismissLoading();
      // Navigator.pop(context);

      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const ChurchSelectorScreen(),
        ),
      );
    } on FirebaseException catch (e) {
      await EaslyLoadingIndicator.dismissLoading();
      debugPrint(e.toString());
      kshowSnackbar(
        errorType: 'error',
        context: context,
        text: e.message!,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      await EaslyLoadingIndicator.dismissLoading();
    }
  }

  @override
  void dispose() {
    imageSelector.close();
    super.dispose();
  }

  @override
  void initState() {
    imageSelector = Provider.of<ImageSelectorProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Provider.of<PageController>(context, listen: false).previousPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutExpo,
        );
        return false;
      },
      child: Scaffold(
        appBar: _backButton(context: context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  const Text('Add profile image.', style: kSFBodyBold),
                  const SizedBox(height: 40),
                  _buildImage(),
                  const SizedBox(height: 40),
                  _buildDoneBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic _backButton({required BuildContext context}) {
    return AppBar(
      leading: TextButton(
        style: kTextButtonStyle,
        child: const Icon(
          Icons.chevron_left,
          color: kBlack,
          size: 40,
        ),
        onPressed: () async {
          await Provider.of<PageController>(context, listen: false)
              .previousPage(
            duration: kPagViewDuration,
            curve: kPagViewCurve,
          );
        },
      ),
    );
  }

  Widget _buildImage() {
    if (Provider.of<ImageSelectorProvider>(context).image?.path != null) {
      return CircleAvatar(
        radius: 90,
        backgroundImage: Image.file(
          Provider.of<ImageSelectorProvider>(context).image!,
          fit: BoxFit.cover,
        ).image,
        backgroundColor: kBlueLight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: TextButton(
            onPressed: () async {
              await Provider.of<ImageSelectorProvider>(context, listen: false)
                  .showSelectionSheet(context: context);
            },
            style: kTextButtonStyle,
            child: Container(),
          ),
        ),
      );
    }
    return CircleAvatar(
      radius: 90,
      backgroundColor: kBlueLight,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        child: TextButton(
          onPressed: () async {
            await Provider.of<ImageSelectorProvider>(context, listen: false)
                .showSelectionSheet(context: context);
          },
          style: kTextButtonStyle,
          child: const Center(
            child: Icon(Icons.photo_camera_outlined, color: kBlack),
          ),
        ),
      ),
    );
  }

  Widget _buildDoneBtn() {
    return Buttons.buildButton(
      context: context,
      color: isLoading ? kDisabledColor : kBlue,
      width: double.infinity,
      btnText: 'Done',
      onPressed: isLoading ? null : submit,
    );
  }
}
