import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DateGenderView extends StatefulWidget {
  const DateGenderView({Key? key}) : super(key: key);

  @override
  State<DateGenderView> createState() => _DateGenderViewState();
}

class _DateGenderViewState extends State<DateGenderView> {
  DateTime? birthDate;

  TextEditingController genderCntlr = TextEditingController();

  String? genderErrorText;

  String? birthDateErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _backButton(context: context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoText(),
              const SizedBox(height: kButtonSpacing),
              _buildGenderSelector(),
              const SizedBox(height: kButtonSpacing),
              _buildBirthdayPicker(),
              const SizedBox(height: kButtonSpacing),
              Buttons.buildBtn(
                context: context,
                btnText: 'Continue',
                width: double.infinity,
                onPressed: () async {
                  await Provider.of<PageController>(context, listen: false)
                      .nextPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutExpo,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic _backButton({required BuildContext context}) {
    return TextButton(
      style: kTextButtonStyle,
      child: const Icon(
        Icons.chevron_left,
        color: kBlack,
        size: 40,
      ),
      onPressed: () {},
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Gender',
            style: kSFBody,
          ),
        ),
        const SizedBox(height: kTextFieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyCheckBox(
              label: 'Male',
              value: 'male',
              groupsValue: genderCntlr.text,
              onChanged: (value) {
                genderCntlr.text = value;
                genderErrorText = Validators.genderValidator(gender: value);
                setState(() {});
              },
            ),
            const SizedBox(width: 10),
            MyCheckBox(
              label: 'Female',
              value: 'female',
              groupsValue: genderCntlr.text,
              onChanged: (value) {
                genderCntlr.text = value;
                genderErrorText = Validators.genderValidator(gender: value);
                setState(() {});
              },
            ),
          ],
        ),
        ErrorTextWidget(errorText: genderErrorText)
      ],
    );
  }

  Widget _buildBirthdayPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Date of birth',
            style: kSFBody,
          ),
        ),
        const SizedBox(height: kTextFieldSpacing),
        Container(
          height: 64,
          decoration: const BoxDecoration(
            color: kBlueLight,
            borderRadius: BorderRadius.all(
              Radius.circular(
                kButtonRadius,
              ),
            ),
          ),
          child: TextButton(
            onPressed: showDatePicker,
            style: kTextButtonStyle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: kBlack,
                        size: kIconSize,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        birthDate == null
                            ? FormalDates.formatDmyyyy(date: DateTime.now())
                            : FormalDates.formatDmyyyy(date: birthDate),
                        style: kSFTextFieldStyle.copyWith(
                          fontWeight: birthDate == null
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    birthDate == null
                        ? ''
                        : ' ${DateTime.now().year - birthDate!.year} years',
                    style: kSFTextFieldStyle.copyWith(
                      fontWeight: birthDate == null
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildBirthDateErrorText()
      ],
    );
  }

  Future<void> showDatePicker() async {
    FocusScope.of(context).requestFocus(FocusNode());
    await showBottomSheet1(
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,
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
                  initialDateTime: birthDate ?? DateTime.now(),
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

  Widget _buildBirthDateErrorText() {
    if (birthDateErrorText == null || birthDate != null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          birthDateErrorText!,
          style: kSFCaption.copyWith(color: kRed),
        )
      ],
    );
  }

  Widget _buildInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Please select your gender ',
          style: kSFHeadLine2,
        ),
        Text(
          'and date of birth.',
          style: kSFHeadLine2,
        ),
      ],
    );
  }
}
