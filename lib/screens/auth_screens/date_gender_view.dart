import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/date_picker.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
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
    final bool hasConnection = await ConnectionChecker().checkConnection();

    if (hasConnection) {
      final signUpProvider =
          Provider.of<SignUpProvider>(context, listen: false);

      setState(() {
        genderErrorText = Validators.genderValidator(
          gender: signUpProvider.gender,
        );

        dateOfBirthErrorText =
            Validators.birthdayValidator(date: signUpProvider.dateOfBirth);
      });
      if (signUpProvider.dateOfBirth != null &&
          signUpProvider.gender.isNotEmpty) {
        await Provider.of<PageController>(context, listen: false).nextPage(
          duration: kPagViewDuration,
          curve: kPagViewCurve,
        );
      }
    } else {
      kshowSnackbar(
        context: context,
        type: SnackBarType.error,
        text: ConnectionChecker.connectionException.message!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Provider.of<PageController>(context, listen: false).previousPage(
          duration: kPagViewDuration,
          curve: kPagViewCurve,
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
                const SizedBox(height: kContentSpacing32),
                _buildGenderSelector(),
                const SizedBox(height: kContentSpacing12),
                _buildBirthdayPicker(),
                const SizedBox(height: kContentSpacing32),
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
          duration: kPagViewDuration,
          curve: kPagViewCurve,
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
          const SizedBox(height: kContentSpacing12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyCheckBox(
                label: 'Male',
                value: 'male',
                groupsValue: signUpProvider.gender,
                onChanged: (value) {
                  signUpProvider.setGender(gender: value);
                  genderErrorText = Validators.genderValidator(
                    gender: signUpProvider.gender,
                  );
                  setState(() {});
                },
              ),
              const SizedBox(width: 10),
              MyCheckBox(
                label: 'Female',
                value: 'female',
                groupsValue: signUpProvider.gender,
                onChanged: (value) {
                  signUpProvider.setGender(gender: value);
                  genderErrorText = Validators.genderValidator(
                    gender: signUpProvider.gender,
                  );
                  setState(() {});
                },
              ),
            ],
          ),
          Validators().showValidationWidget(errorText: genderErrorText)
        ],
      );
    });
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
          const SizedBox(height: kContentSpacing12),
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
                    dateOfBirthErrorText = Validators.birthdayValidator(
                      date: signUpProvider.dateOfBirth,
                    );
                    setState(() {});
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
                          style: signUpProvider.dateOfBirth == null
                              ? kSFBody
                              : kSFBodyBold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Validators().showValidationWidget(errorText: dateOfBirthErrorText)
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
