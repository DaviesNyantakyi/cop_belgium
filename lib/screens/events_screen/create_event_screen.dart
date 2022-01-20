import 'dart:io';

import 'package:cop_belgium/screens/events_screen/events_screen.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventScreen extends StatefulWidget {
  final EventType? eventType;

  const CreateEventScreen({
    Key? key,
    this.eventType,
  }) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final ImagePicker _picker = ImagePicker();
  String? title;
  String? description;
  String? zoomLink;
  String? location;
  DateTime? startDate;
  DateTime? endDate;

  File? image;
  bool isLoading = false;

  Future<void> pickImage({required String type}) async {
    final source = type == 'camera' ? ImageSource.camera : ImageSource.gallery;
    try {
      final pickedImage = await _picker.pickImage(source: source);

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
            toolbarColor: kBlueDark,
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

      Navigator.pop(context);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildImage(),
                const SizedBox(height: 16),
                _buildDescription(),
                const Divider(),
                _buildStartEndDate(),
                const Divider(),
                _buildEventType(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventType() {
    if (widget.eventType == EventType.zoom) {
      return ListTile(
        leading: Image.asset(
          'assets/images/logos/zoom.png',
          width: 32,
        ),
        title: const Text(
          'Zoom Link',
          style: kSFBody,
        ),
        onTap: () {},
        trailing: const Icon(FontAwesomeIcons.chevronRight),
      );
    }
    return ListTile(
      leading: const Icon(
        FontAwesomeIcons.mapMarkerAlt,
        color: kBlueDark,
      ),
      title: const Text(
        'Location',
        style: kSFBody,
      ),
      onTap: () {},
    );
  }

  Widget _buildDescription() {
    return Column(
      children: [
        _buildTF(
          initialValue: title,
          hintText: 'Title',
          style: kSFHeadLine1,
          onChanged: (value) {
            title = value;
          },
        ),
        const Divider(),
        _buildTF(
          initialValue: description,
          style: kSFBodyBold,
          hintText: 'About event',
          onChanged: (value) {
            description = value;
          },
        ),
      ],
    );
  }

  Widget _buildStartEndDate() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            FontAwesomeIcons.calendar,
            color: kBlueDark,
          ),
          title: const Text(
            'Start Date',
            style: kSFBody,
          ),
          trailing: Text(
            FormalDates.formatDmyHm(
              date: DateTime.now(),
            ),
          ),
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.utc(1999, 01, 31),
              lastDate: DateTime.utc(2030, 12, 31),
            );
            startDate = date;
            setState(() {});
          },
        ),
        ListTile(
          leading: const Icon(
            FontAwesomeIcons.calendar,
            color: kBlueDark,
          ),
          title: const Text(
            'End Date',
            style: kSFBody,
          ),
          trailing: Text(
            FormalDates.formatDmyHm(
              date: DateTime.now().add(Duration(hours: 10)),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildTF({
    String? initialValue,
    String? hintText,
    TextStyle? style,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      style: style,
      minLines: 1,
      cursorWidth: 3,
      cursorColor: kBlueDark,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildImage() {
    if (image?.path != null) {
      return Container(
        height: 209,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.file(
              image!,
            ).image,
          ),
          color: kGrey,
        ),
        child: TextButton(
          onPressed: showBottomSheet,
          style: kTextButtonStyle,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(kButtonRadius),
            ),
            child: Container(),
          ),
        ),
      );
    }

    return Container(
      height: 209,
      decoration: const BoxDecoration(
        color: kGrey,
      ),
      child: TextButton(
        onPressed: showBottomSheet,
        style: kTextButtonStyle,
        child: const Center(
          child: Icon(
            FontAwesomeIcons.plus,
            color: kBlueDark,
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

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: TextButton(
        child: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: kBlueDark,
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }
}
