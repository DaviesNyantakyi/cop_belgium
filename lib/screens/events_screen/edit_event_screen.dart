import 'dart:io';

import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/date_picker.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditEventScreen extends StatefulWidget {
  final String eventType;
  final Event event;

  const EditEventScreen({
    Key? key,
    required this.eventType,
    required this.event,
  }) : super(key: key);

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final ImagePicker _picker = ImagePicker();

  String? eventType;

  Event? event;

  File? image;
  bool isLoading = false;

  DatePicker datePicker = DatePicker();

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

      Navigator.pop(context);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    event = widget.event;
    eventType = event?.type;
    if (mounted) {
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            children: [
              _buildImage(),
              const SizedBox(height: 20),
              _buildTitleDescription(),
              const Divider(),
              _buildTypeSelection(),
              const Divider(),
              _buildAddEventTypeDetails(),
              const Divider(),
              _buildStartEndDate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddEventTypeDetails() {
    if (eventType == 'online') {
      return _buildTF(
        initialValue: event?.link,
        hintText: 'Add link',
        style: kSFBody,
        icon: const Icon(
          Icons.link_outlined,
          color: Colors.black,
        ),
        onChanged: (value) {
          event?.link = value;
        },
      );
    }
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: const Icon(
        Icons.location_on_outlined,
        color: kBlack,
      ),
      title: const Text(
        'Add Location',
        style: kSFBody,
      ),
      onTap: () async {},
    );
  }

  Widget _buildTypeSelection() {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: const Text(
        'Type of event',
        style: kSFBody,
      ),
      onTap: () async {
        FocusScope.of(context).unfocus();
        await _showCreateDialog();
      },
      trailing: Text(eventType ?? ' '),
    );
  }

  Future<String?> _showCreateDialog() async {
    return await showDialog<String?>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => SizedBox(
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(kButtonRadius),
            ),
          ),
          title: const Text(
            'Create event',
            style: kSFBodyBold,
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    activeColor: kBlue,
                    value: 'normal',
                    groupValue: eventType,
                    title: const Text('Normal', style: kSFBody),
                    onChanged: (value) {
                      eventType = value!;
                      setState(() {});
                      if (mounted) {
                        this.setState(() {});
                      }
                    },
                  ),
                  RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    activeColor: kBlue,
                    value: 'online',
                    groupValue: eventType,
                    title: const Text('Online', style: kSFBody),
                    onChanged: (value) {
                      eventType = value!;
                      setState(() {});
                      if (mounted) {
                        this.setState(() {});
                      }
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: kSFBody2Bold,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue', style: kSFBody2Bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleDescription() {
    return Column(
      children: [
        _buildTF(
          initialValue: event?.title,
          hintText: 'Title',
          style: kSFHeadLine3,
          onChanged: (value) {
            event?.title = value;
          },
        ),
        const Divider(),
        _buildTF(
          initialValue: event?.description,
          style: kSFBody,
          hintText: 'About event',
          onChanged: (value) {
            event?.description = value;
          },
        ),
      ],
    );
  }

  Widget _buildStartEndDate() {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: const Icon(
            Icons.calendar_today,
            color: kBlack,
          ),
          title: event?.startDate != null
              ? Text(
                  FormalDates.formatEDmyyyy(date: event!.startDate),
                  style: kSFBody2,
                )
              : Text(
                  FormalDates.formatEDmyyyy(date: DateTime.now()),
                  style: kSFBody2,
                ),
          trailing: event?.startDate != null
              ? Text(FormalDates.formatHm(date: event!.startDate))
              : Text(FormalDates.formatHm(date: DateTime.now())),
          onTap: () async {
            await datePicker.showDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDate: event?.startDate ?? DateTime.now(),
              context: context,
              onChanged: (date) {
                event?.startDate = date;
              },
            );
            await datePicker.showDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDate: event!.startDate,
              context: context,
              onChanged: (date) {
                event?.startDate = date;
              },
            );
          },
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: const Icon(
            Icons.calendar_today,
            color: kBlack,
          ),
          title: event?.endDate != null
              ? Text(
                  FormalDates.formatEDmyyyy(date: event!.endDate),
                  style: kSFBody2,
                )
              : Text(
                  FormalDates.formatEDmyyyy(date: DateTime.now()),
                  style: kSFBody2,
                ),
          trailing: event?.endDate != null
              ? Text(FormalDates.formatHm(date: event!.endDate))
              : Text(FormalDates.formatHm(
                  date: DateTime.now().add(
                    const Duration(minutes: 30),
                  ),
                )),
          onTap: () async {
            await datePicker.showDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDate: event?.endDate ?? DateTime.now(),
              context: context,
              onChanged: (date) {
                event?.endDate = date;
              },
            );
            await datePicker.showDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDate: event!.endDate,
              context: context,
              onChanged: (date) {
                event?.endDate = date;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTF({
    String? initialValue,
    String? hintText,
    TextStyle? style,
    Widget? icon,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      style: style,
      minLines: 1,
      cursorWidth: 3,
      cursorColor: kBlack,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
        border: InputBorder.none,
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildImage() {
    if (event?.image != null) {
      return Container(
        height: 260,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(event!.image),
          ),
          color: kGrey,
          borderRadius: const BorderRadius.all(
            Radius.circular(kCardRadius),
          ),
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
    if (image?.path != null) {
      return Container(
        height: 260,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.file(
              image!,
            ).image,
          ),
          color: kGrey,
          borderRadius: const BorderRadius.all(
            Radius.circular(kCardRadius),
          ),
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
      height: 260,
      decoration: const BoxDecoration(
        color: kGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(kCardRadius),
        ),
      ),
      child: TextButton(
        onPressed: showBottomSheet,
        style: kTextButtonStyle,
        child: const Center(
          child: Icon(
            Icons.collections_outlined,
            color: kBlack,
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet() async {
    await showSmallBottomSheet(
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
                    Icons.camera_alt_outlined,
                    color: kBlack,
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
                    Icons.collections_outlined,
                    color: kBlack,
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
                          Icons.delete_outline_outlined,
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
      title: const Text('Edit', style: kSFHeadLine3),
      leading: TextButton(
        child: kBackButton(context: context),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
      actions: [
        TextButton(
          style: kTextButtonStyle,
          child: Container(
            alignment: Alignment.center,
            // margin: const EdgeInsets.only(left: 10, right: kAppbarPadding),
            child: Text('Delete', style: kSFBody.copyWith(color: kRed)),
          ),
          onPressed: () async {},
        ),
        TextButton(
          style: kTextButtonStyle,
          child: Container(
            alignment: Alignment.center,
            // margin: const EdgeInsets.only(left: 10, right: kAppbarPadding),
            child: const Text('Create', style: kSFBody),
          ),
          onPressed: () async {},
        ),
      ],
    );
  }
}
