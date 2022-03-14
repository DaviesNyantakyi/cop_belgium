import 'dart:io';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/date_picker.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/image_picker.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  TextEditingController titleCntlr = TextEditingController();
  TextEditingController descriptionCntlr = TextEditingController();
  TextEditingController linkCntlr = TextEditingController();
  TextEditingController addressCntlr = TextEditingController();

  DatePicker datePicker = DatePicker();
  late MyImagePicker myImagePicker = MyImagePicker();

  File? image;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  bool isLoading = false;
  bool allDayEvent = false;

  Future<void> pickImage() async {
    await myImagePicker.showBottomSheet(
      context: context,
    ) as File?;

    image = myImagePicker.image;

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
          'All-day',
          style: kSFBody,
        ),
        CupertinoSwitch(
          activeColor: kBlue,
          value: allDayEvent,
          onChanged: (value) {
            setState(() {
              allDayEvent = value;
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
          hintText: 'URL',
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
          style: kSFHeadLine3.copyWith(fontWeight: FontWeight.normal),
          maxLines: null,
        ),
        const Divider(),
        MyTextFormField(
          fillColor: Colors.transparent,
          controller: descriptionCntlr,
          style: kSFBody,
          hintText: 'Description',
        ),
      ],
    );
  }

  Widget _buildStartEndDate() {
    if (allDayEvent) {
      return ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: const Text('Start', style: kSFBody),
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
          leading: const Text('Start', style: kSFBody),
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
          leading: const Text('End', style: kSFBody),
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
    if (image?.path != null && image != null) {
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
          onPressed: pickImage,
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
      leading: kBackButton(context: context),
      actions: [
        _buildCreateButton(context: context),
      ],
    );
  }

  Widget _buildCreateButton({required BuildContext context}) {
    return TextButton(
      child: const Text('CREATE', style: kSFBody),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }
}
