import 'dart:io';

import 'package:cop_belgium/screens/events_screen/events_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventScreen extends StatefulWidget {
  final EventType? eventType;
  final bool? editable;

  const CreateEventScreen({
    Key? key,
    this.eventType,
    this.editable,
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
  DateTime? birthDate;

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImage(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
                child: Column(
                  children: [
                    _buildDescription(),
                    const Divider(),
                    _buildEventType(),
                    const Divider(),
                    _buildStartEndDate(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDatePicker() async {
    FocusScope.of(context).requestFocus(FocusNode());
    await showMyBottomSheet(
      isDismissible: false,
      context: context,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: Theme(
                data: ThemeData(),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(1900, 01, 31),
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: (date) {
                    HapticFeedback.lightImpact();

                    birthDate = date;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
            Buttons.buildBtn(
              context: context,
              btnText: 'Done',
              height: kButtonHeight,
              width: double.infinity,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventType() {
    if (widget.eventType == EventType.online) {
      return _buildTF(
        initialValue: title,
        hintText: 'Link',
        style: kSFBodyBold,
        onChanged: (value) {
          title = value;
        },
      );
    }
    return ListTile(
      leading: const Icon(
        FontAwesomeIcons.mapMarkerAlt,
        color: kBlueDark,
      ),
      title: const Text(
        'Add Location',
        style: kSFBody,
      ),
      onTap: () async {},
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
          hintText: 'Event description',
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
          title: startDate != null
              ? Text(FormalDates.formatEDmy(date: startDate))
              : Text(FormalDates.formatEDmy(date: DateTime.now())),
          onTap: () async {
            showDatePicker();
            //   DateTime? pickedDate = await showDatePicker(
            //     context: context,
            //     initialDate: DateTime.now(),
            //     firstDate: DateTime.utc(1999, 01, 31),
            //     lastDate: DateTime.utc(2030, 12, 31),
            //   );

            //   TimeOfDay? pickedTime = await showTimePicker(
            //     context: context,
            //     initialTime: TimeOfDay.now(),
            //   );

            //   if (pickedDate != null && pickedTime != null) {
            //     DateTime newDateTime = DateTime(
            //       pickedDate.year,
            //       pickedDate.month,
            //       pickedDate.day,
            //       pickedTime.hour,
            //       pickedTime.minute,
            //     );
            //     startDate = newDateTime;
            //   }

            //   setState(() {});
          },
        ),
        ListTile(
          leading: const Icon(
            FontAwesomeIcons.calendar,
            color: kBlueDark,
          ),
          title: endDate != null
              ? Text(FormalDates.formatEDmy(date: endDate))
              : Text(FormalDates.formatEDmy(
                  date: DateTime.now().add(const Duration(
                  minutes: 30,
                )))),
          onTap: () async {
            // DateTime? pickedDate = await showDatePicker(
            //   context: context,
            //   initialDate: DateTime.now(),
            //   firstDate: DateTime.utc(1999, 01, 31),
            //   lastDate: DateTime.utc(2030, 12, 31),
            // );

            // TimeOfDay? pickedTime = await showTimePicker(
            //   context: context,
            //   initialTime: TimeOfDay.now(),
            // );

            // if (pickedDate != null && pickedTime != null) {
            //   DateTime newDateTime = DateTime(
            //     pickedDate.year,
            //     pickedDate.month,
            //     pickedDate.day,
            //     pickedTime.hour,
            //     pickedTime.minute,
            //   );
            //   endDate = newDateTime;
            //   setState(() {});
            // }
          },
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
      height: 170,
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
                image != null
                    ? ListTile(
                        onTap: () async {
                          image = null;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        leading: const Icon(
                          FontAwesomeIcons.trash,
                          color: kRed,
                        ),
                        title: Text(
                          'Delete',
                          style: kSFBody.copyWith(color: kRed),
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
      actions: [
        _buildPopupMenu(context: context),
      ],
    );
  }

  Widget _buildPopupMenu({required BuildContext context}) {
    if (widget.editable == true) {
      return PopupMenuButton<String>(
        tooltip: 'Save & Delete',
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        elevation: 4,
        icon: const Icon(
          FontAwesomeIcons.ellipsisV,
          size: 20,
        ),
        onSelected: (String result) async {},
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'save',
              child: Text(
                'Save',
                style: kSFBody,
              ),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: Text(
                'Delete',
                style: kSFBody.copyWith(color: kRed),
              ),
            ),
          ];
        },
      );
    } else {
      return TextButton(
        style: kTextButtonStyle,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 10, right: kAppbarPadding),
          child: const Text('Create', style: kSFBodyBold),
        ),
        onPressed: () async {},
      );
    }
  }
}
