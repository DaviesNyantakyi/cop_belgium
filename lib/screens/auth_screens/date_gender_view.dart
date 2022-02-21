import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/date_picker.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateGenderView extends StatefulWidget {
  const DateGenderView({Key? key}) : super(key: key);

  @override
  State<DateGenderView> createState() => _DateGenderViewState();
}

class _DateGenderViewState extends State<DateGenderView> {
  String? dateOfBirthErrorText;

  String? genderErrorText;

  DatePicker datePicker = DatePicker();

  Future<void> onSubmit() async {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    genderErrorText = Validators.genderValidator(
      gender: signUpProvider.genderCntlr.text,
    );

    dateOfBirthErrorText =
        Validators.birthdayValidator(date: signUpProvider.dateOfBirth);

    setState(() {});

    if (signUpProvider.dateOfBirth != null &&
        signUpProvider.genderCntlr.text.isNotEmpty) {
      await Provider.of<PageController>(context, listen: false).nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutExpo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Provider.of<PageController>(context, listen: false).previousPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutExpo,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _backButton(context: context),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(kBodyPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderText(),
                const SizedBox(height: kButtonSpacing),
                _buildGenderSelector(),
                const SizedBox(height: kButtonSpacing),
                _buildBirthdayPicker(),
                const SizedBox(height: kButtonSpacing),
                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Buttons.buildButton(
      context: context,
      btnText: 'Continue',
      width: double.infinity,
      onPressed: onSubmit,
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
      onPressed: () async {
        await Provider.of<PageController>(context, listen: false).previousPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutExpo,
        );
      },
    );
  }

  Widget _buildGenderSelector() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
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
                groupsValue: signUpProvider.genderCntlr.text,
                onChanged: (value) {
                  signUpProvider.setGender(gender: value);
                },
              ),
              const SizedBox(width: 10),
              MyCheckBox(
                label: 'Female',
                value: 'female',
                groupsValue: signUpProvider.genderCntlr.text,
                onChanged: (value) {
                  signUpProvider.setGender(gender: value);
                },
              ),
            ],
          ),
          _buildGenderValidator(signUpProvider: signUpProvider),
        ],
      );
    });
  }

  Widget _buildGenderValidator({required SignUpProvider signUpProvider}) {
    if (genderErrorText == null) {
      return Container();
    }
    return Validators().showValidationWidget(
      object: signUpProvider.genderCntlr.text.isEmpty
          ? null
          : signUpProvider.genderCntlr.text,
      errorText: genderErrorText,
    );
  }

  Widget _buildBirthValidator({required SignUpProvider signUpProvider}) {
    if (dateOfBirthErrorText == null) {
      return Container();
    }
    return Validators().showValidationWidget(
      object: signUpProvider.dateOfBirth,
      errorText: dateOfBirthErrorText,
    );
  }

  Widget _buildBirthdayPicker() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
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
              onPressed: () async {
                final date = DateTime.now();
                await datePicker.showDatePicker(
                  initialDate: signUpProvider.dateOfBirth ?? date,
                  maxDate: date,
                  mode: CupertinoDatePickerMode.date,
                  context: context,
                  onChanged: (date) {
                    signUpProvider.setDateOfBirth(date: date);
                  },
                );
              },
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
                          signUpProvider.dateOfBirth == null
                              ? FormalDates.formatDmyyyy(date: DateTime.now())
                              : FormalDates.formatDmyyyy(
                                  date: signUpProvider.dateOfBirth),
                          style: kSFTextFieldStyle.copyWith(
                            fontWeight: signUpProvider.dateOfBirth == null
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildBirthValidator(signUpProvider: signUpProvider),
        ],
      );
    });
  }

  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Please select your gender ',
          style: kSFHeadLine2,
        ),
        Text(
          'and date of birth',
          style: kSFHeadLine2,
        ),
      ],
    );
  }
}
