import 'dart:io';

import 'package:cop_belgium/services/fire_storage.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerScreen extends StatefulWidget {
  const PhotoPickerScreen({Key? key}) : super(key: key);

  @override
  State<PhotoPickerScreen> createState() => _PhotoPickerScreenState();
}

class _PhotoPickerScreenState extends State<PhotoPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  final _connectionChecker = ConnectionChecker();

  File? image;
  bool isLoading = false;

  Future<void> pickImage({required String type}) async {
    final source = type == 'camera' ? ImageSource.camera : ImageSource.gallery;
    try {
      bool hasConnection = await _connectionChecker.checkConnection();
      final pickedImage = await _picker.pickImage(source: source);
      if (hasConnection) {
        if (pickedImage != null) {
          setState(() {
            image = File(pickedImage.path);
          });
        }
      } else {
        kshowSnackbar(
          context: context,
          errorType: 'normal',
          text: ConnectionChecker.connectionException.message!,
        );
      }

      Navigator.pop(context);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> submit() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      await EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        indicator: const CircularProgressIndicator(
          color: kBlueDark,
        ),
      );
      await FireStorage().uploadProfileImage(image: image);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      await EasyLoading.dismiss();
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      await EasyLoading.dismiss();
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
      await EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 90),
                const Text(
                  'Choose picture',
                  style: kSFBody,
                ),
                const SizedBox(height: 40),
                _buildImage(),
                const SizedBox(height: 40),
                _buildDoneBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (image?.path != null) {
      return Container(
        width: 296,
        height: 296,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
          color: kGreyLight,
        ),
        child: TextButton(
          onPressed: showBottomSheet,
          style: kTextButtonStyle,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(kButtonRadius),
            ),
            child: Image.file(
              image!,
              fit: BoxFit.cover,
              width: 296,
              height: 296,
            ),
          ),
        ),
      );
    }
    return Container(
      width: 296,
      height: 296,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(kButtonRadius),
        ),
        color: kGreyLight,
      ),
      child: TextButton(
        onPressed: showBottomSheet,
        style: kTextButtonStyle,
        child: const Center(
          child: Icon(
            FontAwesomeIcons.plus,
            color: kGrey,
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet() async {
    await showMyFastingBottomSheet(
      height: 150,
      context: context,
      child: Material(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () async {
                    await pickImage(type: 'camera');
                  },
                  leading: const Icon(
                    FontAwesomeIcons.camera,
                    color: kBlueDark,
                  ),
                  title: const Text(
                    'Camera',
                    style: kSFBody,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await pickImage(type: 'gallery');
                  },
                  leading: const Icon(
                    FontAwesomeIcons.images,
                    color: kBlueDark,
                  ),
                  title: const Text(
                    'Gallery',
                    style: kSFBody,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoneBtn() {
    return Buttons.buildBtn(
      context: context,
      color: kYellow,
      btnText: 'Done',
      onPressed: isLoading ? null : submit,
    );
  }
}
