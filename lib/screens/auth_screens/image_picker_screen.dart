import 'dart:io';

import 'package:cop_belgium/providers/signup_notifier.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/image_picker.dart';
import 'package:cop_belgium/widgets/buttons.dart';

import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final MyImagePicker myImagePicker = MyImagePicker();
  Future<void> submit() async {
    try {
      Provider.of<SignUpNotifier>(context, listen: false).setProfileImage(
        image: myImagePicker.image,
      );

      bool hasConnection = await ConnectionChecker().checkConnection();
      if (hasConnection) {
        await Provider.of<PageController>(context, listen: false).nextPage(
          duration: kPagViewDuration,
          curve: kPagViewCurve,
        );
      } else {
        throw ConnectionChecker.connectionException;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      kshowSnackbar(
        type: SnackBarType.error,
        context: context,
        text: e.message!,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> pickImage() async {
    await myImagePicker.showBottomSheet(
      context: context,
    ) as File?;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Provider.of<PageController>(context, listen: false).previousPage(
          duration: kPagViewDuration,
          curve: kPagViewCurve,
        );
        return false;
      },
      child: Scaffold(
        appBar: _backButton(context: context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: kBodyPadding, vertical: kBodyPadding),
            child: Column(
              children: [
                const Text('Add profile image', style: kSFHeadLine2),
                const SizedBox(height: 32),
                _buildImage(),
                const SizedBox(height: kContentSpacing32),
                _buildContinueButton(),
              ],
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
    if (myImagePicker.image?.path != null) {
      return CircleAvatar(
        radius: 90,
        backgroundImage: Image.file(
          myImagePicker.image!,
          fit: BoxFit.cover,
        ).image,
        backgroundColor: kBlueLight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: TextButton(
            onPressed: pickImage,
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
          onPressed: pickImage,
          style: kTextButtonStyle,
          child: const Center(
            child: Icon(Icons.collections_outlined, color: kBlack),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Buttons.buildButton(
      context: context,
      color: kBlue,
      width: double.infinity,
      btnText: 'Continue',
      onPressed: submit,
    );
  }
}
