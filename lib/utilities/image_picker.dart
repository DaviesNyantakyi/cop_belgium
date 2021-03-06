import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MyImagePicker {
  File? image;

  final ImagePicker _picker = ImagePicker();

  Future<void> showBottomSheet({
    required BuildContext context,
  }) async {
    return await showMyBottomSheet(
      height: null,
      padding: EdgeInsets.zero,
      fullScreenHeight: null,
      context: context,
      child: Material(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _selectionTile(
                  context: context,
                  icon: Icons.photo_camera_outlined,
                  text: 'Camera',
                  onPressed: () async {
                    const source = ImageSource.camera;
                    final pickedFile =
                        await _pickImage(context: context, source: source);
                    if (pickedFile?.path != null) {
                      image = await _imageCropper(file: File(pickedFile!.path));
                    }
                    Navigator.pop(context);
                  },
                ),
                _selectionTile(
                  context: context,
                  icon: Icons.collections_outlined,
                  text: 'Gallery',
                  onPressed: () async {
                    const source = ImageSource.gallery;
                    final pickedFile =
                        await _pickImage(context: context, source: source);
                    if (pickedFile?.path != null) {
                      image = await _imageCropper(file: File(pickedFile!.path));
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectionTile(
      {required VoidCallback onPressed,
      required BuildContext context,
      required IconData icon,
      required String text,
      Color? color}) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(
        icon,
        color: color,
        size: kIconSize,
      ),
      title: Text(text, style: kSFBody.copyWith(color: color)),
    );
  }

  Future<XFile?> _pickImage({
    required BuildContext context,
    required ImageSource source,
  }) async {
    try {
      XFile? selectedImage;

      if (source == ImageSource.gallery) {
        // pick image from storage if permission granted.
        var status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          selectedImage = await _picker.pickImage(
            source: source,
          );
        }
        // If the permission permanlty denied showdialog
        if (status == PermissionStatus.permanentlyDenied) {
          await _showPermanltyDeniedDialog(
            headerWidget: const Icon(
              Icons.folder,
              color: Colors.white,
              size: 32,
            ),
            context: context,
            instructions: 'Tap Settings > Permissions, and turn on Storage',
          );
        }
        return selectedImage;
      }

      // pick image from storage and camera if permission granted.
      if (source == ImageSource.camera) {
        //Request camera and storage permission.
        var statusCamera = await Permission.camera.request();
        var statusStorage = await Permission.storage.request();

        //pick image if the permission is granted.
        if (statusStorage == PermissionStatus.granted &&
            statusCamera == PermissionStatus.granted) {
          selectedImage = await _picker.pickImage(
            source: source,
          );
        }

        // Ask to enable permission if permanlty denied.
        if (statusStorage == PermissionStatus.permanentlyDenied ||
            statusCamera == PermissionStatus.permanentlyDenied) {
          await _showPermanltyDeniedDialog(
            headerWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.photo_camera_outlined,
                  color: Colors.white,
                  size: 32,
                ),
                Icon(
                  Icons.add_outlined,
                  color: Colors.white,
                  size: 32,
                ),
                Icon(
                  Icons.folder_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ],
            ),
            context: context,
            instructions:
                'Tap Settings > Permissions, and turn on Camera and Storage',
          );
        }
        return selectedImage;
      }
      return null;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // Cropp the image using the file path
  Future<File?> _imageCropper({File? file}) async {
    return await ImageCropper().cropImage(
      sourcePath: file!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
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
  }

  Future<String?> _showPermanltyDeniedDialog({
    required BuildContext context,
    required String instructions,
    required Widget headerWidget,
  }) async {
    return showMyDialog(
      barrierDismissible: true,
      context: context,
      title: Container(
        height: 100,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(kRadius),
          ),
        ),
        child: headerWidget,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Allow Cop Belgium access to your device\'s photo\'s, media and files.',
            style: kSFBody,
          ),
          Text(
            instructions,
            style: kSFBody,
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Not now', style: kSFBody2Bold),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await AppSettings.openAppSettings();
          },
          child: const Text('Settings', style: kSFBody2Bold),
        ),
      ],
    );
  }
}
