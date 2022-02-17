import 'dart:io';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectorProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  File? image;
  ImageSource? _selectedSource;

  // Select  and crop a image from gallery or camera.
  Future<void> pickImage({required BuildContext context}) async {
    try {
      // pick image from gallery or camera.
      // The source is selected from the bottomsheet. The default value is gallery
      final selectedImage = await _picker.pickImage(
        source: _selectedSource ?? ImageSource.gallery,
      );

      // Cropp the selected image.
      if (selectedImage != null) {
        image = await _imageCropper(file: File(selectedImage.path));
      }

      notifyListeners();
      Navigator.pop(context);
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

  // Choose a image source and delete selected Image.
  Future<void> showSelectionSheet({required BuildContext context}) async {
    await showSmallBottomSheet(
      height: null,
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
                image != null
                    ? _selectionTile(
                        onPressed: () {
                          image = null;
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
    image = null;
    _selectedSource = null;
  }
}
