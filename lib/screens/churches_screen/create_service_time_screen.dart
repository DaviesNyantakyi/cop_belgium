import 'package:cop_belgium/models/service_time_model.dart';
import 'package:cop_belgium/screens/churches_screen/widgets/build_tile.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/date_picker.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddServiceTimeScreen extends StatefulWidget {
  final ServiceTimeModel serviceTimeModel;
  const AddServiceTimeScreen({
    Key? key,
    required this.serviceTimeModel,
  }) : super(key: key);

  @override
  State<AddServiceTimeScreen> createState() => _AddServiceTimeScreenState();
}

class _AddServiceTimeScreenState extends State<AddServiceTimeScreen> {
  ServiceTimeModel? serviceTime;

  DatePicker datePicker = DatePicker();

  String? day = 'Sunday';
  DateTime time = DateTime.now();
  TextEditingController? descriptionCntlr;

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  void initState() {
    initInfo();
    super.initState();
  }

  void initInfo() {
    serviceTime = widget.serviceTimeModel;
    descriptionCntlr = TextEditingController(
      text: widget.serviceTimeModel.description,
    );
  }

  void create() {
    FocusScope.of(context).unfocus();
    serviceTime = ServiceTimeModel(
      day: day,
      time: time,
      description: descriptionCntlr?.text,
    );

    Navigator.pop(context, serviceTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kBackButton(context: context),
        title: Text(
          'Service time',
          style: kSFHeadLine3,
        ),
        actions: [
          _buildCreateButton(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            children: [
              _buildDayDropDown(),
              const SizedBox(height: kContentSpacing8),
              _buildTimeSelection(),
              const SizedBox(height: kContentSpacing8),
              _buildDescriptionField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayDropDown() {
    return ServiceTimeTile(
      child: DropdownButton<String>(
        value: day,
        isExpanded: true,
        underline: Container(),
        icon: const Icon(
          Icons.expand_more_outlined,
          color: kBlack,
        ),
        style: kSFBody,
        onChanged: (value) {
          day = value;
          if (mounted) {
            setState(() {});
          }
        },
        items: days.map((day) {
          return DropdownMenuItem<String>(
            value: day,
            child: Text(
              day,
              style: kSFBody,
            ),
          );
        }).toList(),
      ),
      onPressed: () {},
    );
  }

  Widget _buildTimeSelection() {
    return ServiceTimeTile(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Time', style: kSFBody),
          Text(
            FormalDates.formatHm(
              date: time,
            ),
            style: kSFBody,
          ),
        ],
      ),
      onPressed: () async {
        await datePicker.showDatePicker(
          initialDate: time,
          maxDate: kMaxDate,
          mode: CupertinoDatePickerMode.time,
          context: context,
          onChanged: (value) {
            time = value;
            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return MyTextFormField(
      controller: descriptionCntlr!,
      hintText: 'Description (optional)',
    );
  }

  Widget _buildCreateButton() {
    return TextButton(
      onPressed: create,
      child: const Text(
        'SAVE',
        style: kSFBody,
      ),
    );
  }
}
