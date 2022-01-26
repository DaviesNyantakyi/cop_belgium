import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/screens/image_picker_screen.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/checkbox.dart';
import 'package:cop_belgium/widgets/textfiel.dart';

class SignUpScreen extends StatefulWidget {
  static String signUpScreen = 'signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  bool showPassword = false;
  String? nameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? birthDateErrorText;
  String? genderErrorText;

  TextEditingController firstNameCntlr = TextEditingController();
  TextEditingController lastNameCntlr = TextEditingController();
  TextEditingController emailCntlr = TextEditingController();
  TextEditingController passwordCntlr = TextEditingController();
  TextEditingController genderCntlr = TextEditingController();
  DateTime? birthDate;

  // only validate when the signup button is pressed

  Future<void> signUp() async {
    FocusScope.of(context).unfocus();
    EasyLoading.show();
    try {
      isLoading = true;

      bool isValid = validateForm();

      if (isValid) {
        final user = CopUser(
          firstName: firstNameCntlr.text,
          lastName: lastNameCntlr.text,
          email: emailCntlr.text,
          birthDate: birthDate!,
          gender: genderCntlr.text,
          isAdmin: false,
        );
        if (mounted) {
          setState(() {});
        }

        await FireAuth()
            .signUpEmailPassword(user: user, password: passwordCntlr.text);
        await EasyLoading.dismiss();

        Navigator.pop(context);

        await Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const ImagePickerScreen()),
        );
      }

      if (mounted) {
        setState(() {});
      }
    } on FirebaseAuthException catch (e) {
      await EasyLoading.dismiss();
      kshowSnackbar(
        context: context,
        errorType: 'error',
        text: e.message!,
      );
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      EasyLoading.dismiss();
      if (mounted) {
        setState(() {});
      }
    }
  }

  bool validateForm() {
    nameErrorText = Validators.nameValidator(
      firstName: firstNameCntlr.text,
      lastName: lastNameCntlr.text,
    );
    emailErrorText = Validators.emailValidator(
      email: emailCntlr.text,
    );
    passwordErrorText = Validators.passwordTextValidator(
      password: passwordCntlr.text,
    );

    birthDateErrorText = Validators.birthdayValidator(date: birthDate);

    genderErrorText = Validators.genderValidator(gender: genderCntlr.text);

    if (nameErrorText == null &&
        emailErrorText == null &&
        passwordErrorText == null &&
        birthDateErrorText == null &&
        genderErrorText == null) {
      return true;
    }
    return false;
  }

  Widget _buildNameErrorText() {
    if (nameErrorText == null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          nameErrorText!,
          style: kSFCaptionBold.copyWith(color: kRed),
        )
      ],
    );
  }

  Widget _buildEmailErrorText() {
    if (emailErrorText == null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          emailErrorText!,
          style: kSFCaption.copyWith(color: kRed),
        )
      ],
    );
  }

  Widget _buildPasswordErrorText() {
    if (passwordErrorText == null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          passwordErrorText!,
          style: kSFCaption.copyWith(color: kRed),
        )
      ],
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

  Widget _builGenderErrorText() {
    if (genderErrorText == null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          genderErrorText!,
          style: kSFCaption.copyWith(color: kRed),
        )
      ],
    );
  }

  @override
  void dispose() {
    firstNameCntlr.dispose();
    lastNameCntlr.dispose();
    emailCntlr.dispose();
    passwordCntlr.dispose();
    genderCntlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kBodyPadding),
        child: SafeArea(
          child: Column(
            children: [
              _buildForm(),
              const SizedBox(height: kTextFieldSpacing),
              _buildBirthdayPicker(),
              const SizedBox(height: kButtonSpacing),
              _buildGenderSelector(),
              const SizedBox(height: kButtonSpacing),
              _buildSingUpBtn(),
              const SizedBox(height: kButtonSpacing),
              _buildAccountQuestion(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBirthdayPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                children: [
                  const Icon(
                    FontAwesomeIcons.calendar,
                    color: kBlueDark,
                    size: kIconSize,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    birthDate == null
                        ? 'Date of birth'
                        : FormalDates.formatDmyyyy(date: birthDate),
                    style: kSFTextFieldStyle,
                  )
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

  Widget _buildAccountQuestion() {
    return TextButton(
      style: kTextButtonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
            child: Text(
              'Already a member? ',
              style: kSFBody,
            ),
          ),
          Flexible(
            child: Text(
              'Log in',
              style: kSFBodyBold.copyWith(color: kBlueDark),
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: MyTextField(
                controller: firstNameCntlr,
                hintText: 'First Name',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  nameErrorText = Validators.nameValidator(
                    firstName: value,
                    lastName: lastNameCntlr.text,
                  );

                  setState(() {});
                },
              ),
            ),
            const SizedBox(width: kTextFieldSpacing),
            Expanded(
              child: MyTextField(
                controller: lastNameCntlr,
                hintText: 'Last Name',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  nameErrorText = Validators.nameValidator(
                    firstName: firstNameCntlr.text,
                    lastName: value,
                  );
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        _buildNameErrorText(),
        const SizedBox(height: kTextFieldSpacing),
        MyTextField(
          controller: emailCntlr,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            emailErrorText = Validators.emailValidator(email: value);
            setState(() {});
          },
        ),
        _buildEmailErrorText(),
        const SizedBox(height: kTextFieldSpacing),
        MyTextField(
          controller: passwordCntlr,
          hintText: 'Password',
          obscureText: showPassword ? false : true,
          textInputAction: TextInputAction.done,
          suffixIcon: GestureDetector(
            child: Icon(
              showPassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
              color: kBlueDark,
            ),
            onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
          onChanged: (value) {
            passwordErrorText =
                Validators.passwordTextValidator(password: value);
            setState(() {});
          },
        ),
        _buildPasswordErrorText(),
      ],
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
        const SizedBox(height: 10),
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
        _builGenderErrorText(),
      ],
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: kBlueDark,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: const Text(
        'Create account',
        style: kSFHeadLine2,
      ),
    );
  }

  Widget _buildSingUpBtn() {
    return Buttons.buildBtn(
      context: context,
      color: isLoading ? kGrey : kYellowDark,
      btnText: 'Sign up',
      onPressed: isLoading ? null : signUp,
      width: double.infinity,
    );
  }
}
