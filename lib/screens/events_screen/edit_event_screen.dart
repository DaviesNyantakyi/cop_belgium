import 'dart:io';

import 'package:cop_belgium/models/event_model.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/date_picker.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/image_picker.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditEventScreen extends StatefulWidget {
  final EventModel event;
  const EditEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  File? image;
  late MyImagePicker myImagePicker = MyImagePicker();
  DatePicker datePicker = DatePicker();

  TextEditingController titleCntlr = TextEditingController();
  TextEditingController aboutCntlr = TextEditingController();
  TextEditingController linkCntlr = TextEditingController();
  TextEditingController addressCntlr = TextEditingController();
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();

  bool isLoading = false;
  bool singleEvent = true;

  Future<void> pickImage() async {
    await myImagePicker.showBottomSheet(
      context: context,
    ) as File?;

    setState(() {});
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
    return Column(
      children: [
        MyTextFormField(
          fillColor: Colors.transparent,
          controller: addressCntlr,
          hintText: 'Address',
          maxLines: 1,
          style: kSFBody,
        ),
        const Divider(),
        MyTextFormField(
          fillColor: Colors.transparent,
          controller: linkCntlr,
          hintText: 'Link',
          style: kSFBody,
          maxLines: null,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Widget _buildTitleDescription() {
    return Column(
      children: [
        MyTextFormField(
          fillColor: Colors.transparent,
          controller: titleCntlr,
          hintText: 'Title',
          style: kSFHeadLine3,
          maxLines: null,
        ),
        const Divider(),
        MyTextFormField(
          fillColor: Colors.transparent,
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

  Widget _buildImage() {
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
          onPressed: () async {},
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
        onPressed: pickImage,
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
      title: const Text('Edit', style: kSFHeadLine3),
      leading: kBackButton(context: context),
      actions: [
        TextButton(
          child: const Text('SAVE', style: kSFBody),
          onPressed: () async {
            Navigator.of(context)
              ..pop()
              ..pop();
          },
        )
      ],
    );
  }
}
