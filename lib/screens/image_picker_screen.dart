import 'dart:io';

import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/church_selector.dart';
import 'package:cop_belgium/widgets/easy_loading.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// TODO: ask for permision gallary and camera (check whatsaap process)

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  final _connectionChecker = ConnectionChecker();

  File? image;
  bool isLoading = false;

  TextStyle fontStyle = kSFBody;

  Future<void> pickImage({required String type}) async {
    final source = type == 'camera' ? ImageSource.camera : ImageSource.gallery;
    try {
      bool hasConnection = await _connectionChecker.checkConnection();
      final pickedImage = await _picker.pickImage(source: source);
      if (hasConnection) {
        if (pickedImage != null) {
          image = File(pickedImage.path);

          File? croppedImage = await ImageCropper.cropImage(
            sourcePath: image!.path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: kBlack,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            iosUiSettings: const IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),
          );

          if (mounted) {
            setState(() {
              image = croppedImage;
            });
          }
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
          ));
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
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget _buildImage() {
    if (image?.path != null) {
      return CircleAvatar(
        radius: 90,
        backgroundImage: Image.file(
          image!,
          fit: BoxFit.cover,
        ).image,
        backgroundColor: kBlueLight,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: TextButton(
            onPressed: showBottomSheet,
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
          onPressed: showBottomSheet,
          style: kTextButtonStyle,
          child: const Center(
            child: Icon(
              Icons.photo_camera_outlined,
              color: kBlack,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet() async {
    await showBottomSheet2(
      height: kPickerBottomSheetHeight,
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
                    Icons.photo_camera_outlined,
                    color: kBlack,
                    size: kIconSize,
                  ),
                  title: Text(
                    'Camera',
                    style: fontStyle,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await pickImage(type: 'gallery');
                  },
                  leading: const Icon(
                    Icons.collections_outlined,
                    color: kBlack,
                    size: kIconSize,
                  ),
                  title: Text(
                    'Gallery',
                    style: fontStyle,
                  ),
                ),
                image != null
                    ? ListTile(
                        onTap: () async {
                          image = null;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        leading: const Icon(
                          Icons.delete_outline,
                          color: kRed,
                          size: kIconSize,
                        ),
                        title: Text(
                          'Delete',
                          style: fontStyle.copyWith(color: kRed),
                        ),
                      )
                    : Container(),
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
      color: isLoading ? kDisabledColor : kBlue,
      width: double.infinity,
      btnText: 'Done',
      onPressed: isLoading ? null : submit,
    );
  }
}
