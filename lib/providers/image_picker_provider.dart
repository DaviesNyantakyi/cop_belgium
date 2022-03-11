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

class ImagePickerProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  ImageSource? _selectedSource;

  File? get selectedImage => _image;

  // pick image from gallery or camera.
  // The source is selected from the bottomsheet. The default source is gallery
  Future<void> pickImage({required BuildContext context}) async {
    try {
      // Remove bottomSheet
      Navigator.pop(context);

      XFile? selectedImage;

      if (_selectedSource == ImageSource.gallery) {
        // pick image from storage if permission granted.
        var status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          selectedImage = await _picker.pickImage(
            source: _selectedSource ?? ImageSource.gallery,
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
      }

      // pick image from storage and camera if permission granted.
      if (_selectedSource == ImageSource.camera) {
        //Request camera and storage permission.
        var statusCamera = await Permission.camera.request();
        var statusStorage = await Permission.storage.request();

        //pick image if the permission is granted.
        if (statusStorage == PermissionStatus.granted &&
            statusCamera == PermissionStatus.granted) {
          selectedImage = await _picker.pickImage(
            source: _selectedSource ?? ImageSource.gallery,
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
      }

      // Cropp the selected image.
      if (selectedImage != null) {
        _image = await _imageCropper(file: File(selectedImage.path));
      }

      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  // Cropp the image using the file path
  Future<File?> _imageCropper({File? file}) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: file!.path,
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
    return croppedImage;
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
            Radius.circular(kCardRadius),
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

  // Choose a image source and delete selected Image.
  Future<void> showBottomSheet({required BuildContext context}) async {
    await showMyBottomSheet(
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
                  onPressed: () async {
                    _selectedSource = ImageSource.camera;
                    await pickImage(context: context);
                    notifyListeners();
                  },
                  context: context,
                  icon: Icons.photo_camera_outlined,
                  text: 'Camera',
                ),
                _selectionTile(
                  onPressed: () async {
                    _selectedSource = ImageSource.gallery;
                    await pickImage(context: context);
                    notifyListeners();
                  },
                  context: context,
                  icon: Icons.collections_outlined,
                  text: 'Gallery',
                ),
                _image != null
                    ? _selectionTile(
                        onPressed: () {
                          _image = null;
                          Navigator.pop(context);
                          notifyListeners();
                        },
                        context: context,
                        icon: Icons.delete_outline_outlined,
                        text: 'Delete',
                        color: kRed,
                      )
                    : Container(),
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

  // reset the selected image.
  void close() {
    _image = null;
    _selectedSource = null;
  }
}
