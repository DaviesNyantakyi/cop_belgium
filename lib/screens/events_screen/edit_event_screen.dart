import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/providers/image_picker_provider.dart';
import 'package:cop_belgium/screens/events_screen/event_detail_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/date_picker.dart';
import 'package:cop_belgium/utilities/enum_to_string.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({
    Key? key,
    required String eventType,
    required Event event,
  }) : super(key: key);

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late ImagePickerProvider imagePickerProvider;
  DatePicker datePicker = DatePicker();

  EventType? eventType = EventType.normal;

  TextEditingController titleCntlr = TextEditingController();
  TextEditingController aboutCntlr = TextEditingController();
  TextEditingController linkCntlr = TextEditingController();
  TextEditingController addressCntlr = TextEditingController();
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();

  bool isLoading = false;
  bool singleEvent = true;

  @override
  void initState() {
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    imagePickerProvider.close();
    super.dispose();
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
              Padding(
                padding: const EdgeInsets.all(kBodyPadding),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildTitleDescription(),
                    const Divider(),
                    _buildTypeSelection(),
                    const Divider(),
                    _buildAddEventTypeDetails(),
                    const Divider(),
                    _buildEventToggle(),
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

  Widget _buildEventToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'One-day event',
          style: kSFBody,
        ),
        CupertinoSwitch(
          activeColor: kBlue,
          value: singleEvent,
          onChanged: (value) {
            setState(() {
              singleEvent = value;
            });
          },
        )
      ],
    );
  }

  Widget _buildAddEventTypeDetails() {
    if (eventType == EventType.online) {
      return _buildTextFormField(
        controller: linkCntlr,
        hintText: 'Add link',
        style: kSFBody,
        icon: const Icon(
          Icons.link_outlined,
          color: Colors.black,
        ),
      );
    }
    return _buildTextFormField(
      controller: addressCntlr,
      hintText: 'Address',
      style: kSFBody,
      icon: const Icon(
        Icons.location_on_outlined,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTypeSelection() {
    // ignore: unused_local_variable
    IconData icon = Icons.place_outlined;

    if (eventType == EventType.normal) {
      icon = Icons.link_outlined;
    }
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
      trailing: Text(enumToString(object: eventType)),
    );
  }

  Future<String?> _showCreateDialog() async {
    return await showMyDialog(
      context: context,
      title: const Text(
        'Create event',
        style: kSFHeadLine3,
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<EventType>(
                contentPadding: EdgeInsets.zero,
                activeColor: kBlue,
                value: EventType.normal,
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
              RadioListTile<EventType>(
                contentPadding: EdgeInsets.zero,
                activeColor: kBlue,
                value: EventType.online,
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
          onPressed: () {
            if (eventType == EventType.normal) {
              linkCntlr.clear();
            } else {
              addressCntlr.clear();
            }
            Navigator.pop(context);
          },
          child: const Text('OK', style: kSFBody2Bold),
        ),
      ],
    );
  }

  Widget _buildTitleDescription() {
    return Column(
      children: [
        _buildTextFormField(
          controller: titleCntlr,
          hintText: 'Title',
          style: kSFHeadLine3,
        ),
        const Divider(),
        _buildTextFormField(
          controller: aboutCntlr,
          style: kSFBody,
          hintText: 'About event',
        ),
      ],
    );
  }

  Widget _buildStartEndDate() {
    if (singleEvent) {
      return ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const Icon(
          Icons.calendar_today,
          color: kBlack,
        ),
        title: Text(
          FormalDates.formatEDmyyyy(date: startDate),
          style: kSFBody2,
        ),
        trailing: Text(FormalDates.formatHm(date: startDate)),
        onTap: () async {
          await datePicker.showDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDate: startDate,
            context: context,
            onChanged: (date) {
              startDate = date;
              setState(() {});
            },
          );

          if (mounted) {
            setState(() {});
          }
          await datePicker.showDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDate: startDate,
            context: context,
            onChanged: (date) {
              startDate = date;
              setState(() {});
            },
          );
        },
      );
    }

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: const Icon(
            Icons.calendar_today,
            color: kBlack,
          ),
          title: Text(
            FormalDates.formatEDmyyyy(date: startDate),
            style: kSFBody2,
          ),
          trailing: Text(FormalDates.formatHm(date: startDate)),
          onTap: () async {
            await datePicker.showDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDate: startDate,
              context: context,
              onChanged: (date) {
                startDate = date;
                setState(() {});
              },
            );

            if (mounted) {
              setState(() {});
            }
            await datePicker.showDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDate: startDate,
              context: context,
              onChanged: (date) {
                startDate = date;
                setState(() {});
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
          title: Text(
            FormalDates.formatEDmyyyy(date: endDate),
            style: kSFBody2,
          ),
          trailing: Text(FormalDates.formatHm(date: endDate)),
          onTap: () async {
            await datePicker.showDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDate: endDate,
              context: context,
              onChanged: (date) {
                endDate = date;
                setState(() {});
              },
            );
            if (mounted) {
              setState(() {});
            }
            await datePicker.showDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDate: endDate,
              context: context,
              onChanged: (date) {
                endDate = date;
                setState(() {});
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    String? initialValue,
    String? hintText,
    TextStyle? style,
    Widget? icon,
    TextEditingController? controller,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
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
    final image = Provider.of<ImagePickerProvider>(context).selectedImage;
    if (image?.path != null) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.30,
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
          onPressed: () async {
            await Provider.of<ImagePickerProvider>(context, listen: false)
                .showBottomSheet(context: context);
          },
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
        onPressed: () async {
          await Provider.of<ImagePickerProvider>(context, listen: false)
              .showBottomSheet(
            context: context,
          );
        },
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

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      leading: kBackButton(context: context),
      actions: [
        _buildCreateButton(context: context),
      ],
    );
  }

  Widget _buildCreateButton({required BuildContext context}) {
    return TextButton(
      child: const Text('SAVE', style: kSFBodyBold),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }
}
