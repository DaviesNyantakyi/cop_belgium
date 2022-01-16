import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/screens/image_picker_screen.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/easy_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final _nameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  bool isSubmit = false;
  bool isLoading = false;

  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? gender;

  Future<void> submit() async {
    setState(() {
      isSubmit = true;
    });
    FocusScope.of(context).unfocus();
    bool nameIsValid = _nameFormKey.currentState!.validate();
    bool emailIsValid = _emailFormKey.currentState!.validate();
    bool passworIsValid = _passwordFormKey.currentState!.validate();

    if (nameIsValid && emailIsValid && passworIsValid && gender != null) {
      try {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }
        await EaslyLoadingIndicator.showLoading();

        final userObject = CopUser(
          firstName: firstName!,
          lastName: lastName!,
          email: email!,
          gender: gender!,
        );

        final user = await Authentication().signUpWithEmail(
          user: userObject,
          password: password,
        );

        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        if (user != null) {
          Navigator.pop(context);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ImagePickerScreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        debugPrint(e.toString());
        await EaslyLoadingIndicator.dismissLoading();

        kshowSnackbar(
          errorType: 'error',
          context: context,
          text: e.message.toString(),
        );
      } finally {
        if (mounted) {
          setState(() {
            isSubmit = false;
            isLoading = false;
          });
        }
        await EaslyLoadingIndicator.dismissLoading();
      }
    }
  }

  Future<void> loginGoogle() async {
    try {
      FocusScope.of(context).unfocus();
    } catch (e) {}
  }

  Future<void> loginApple() async {
    try {
      FocusScope.of(context).unfocus();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20)
                .copyWith(top: kBodyPadding),
            child: Column(
              children: [
                _buildForm(),
                const SizedBox(height: kTextFieldSpacing),
                const SizedBox(height: kTextFieldSpacing),
                _buildGenderSelector(),
                const SizedBox(height: kButtonSpacing),
                _buildSingUpBtn(),
                const SizedBox(height: kButtonSpacing),
                _buildDivider(),
                const SizedBox(height: kButtonSpacing),
                _buildSocialBtn(
                  icon: 'assets/images/icons/google.png',
                  label: 'Continue with Google',
                  submit: loginGoogle,
                ),
                const SizedBox(height: kTextFieldSpacing),
                _buildSocialBtn(
                  icon: 'assets/images/icons/apple.png',
                  label: 'Continue with Apple',
                  submit: loginApple,
                ),
                const SizedBox(height: kButtonSpacing),
                _buildAccountQuestion(),
              ],
            ),
          ),
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
              'Log In',
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

  Widget _buildSocialBtn(
      {required String icon,
      required String label,
      required VoidCallback submit}) {
    return Buttons.buildSocialBtn(
      icon: SizedBox(
        height: 40,
        child: Image.asset(
          icon,
        ),
      ),
      label: Text(
        label,
        style: kSFBody,
      ),
      context: context,
      color: isLoading ? kGrey : Colors.white,
      onPressed: isLoading ? null : submit,
    );
  }

  Widget _buildDivider() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(
          width: 100,
          child: Divider(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('OR', style: kSFBody),
        ),
        SizedBox(
          width: 100,
          child: Divider(),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        Form(
          key: _nameFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                hintText: 'First Name',
                obscureText: false,
                validator: Validators.nameValidator,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  firstName = value;
                },
              ),
              const SizedBox(height: kTextFieldSpacing),
              MyTextField(
                hintText: 'Last Name',
                obscureText: false,
                validator: Validators.nameValidator,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  lastName = value;
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: kTextFieldSpacing),
        Form(
          key: _emailFormKey,
          child: MyTextField(
            hintText: 'Email',
            obscureText: false,
            validator: Validators.emailTextValidator,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              email = value;
            },
          ),
        ),
        const SizedBox(height: kTextFieldSpacing),
        Form(
          key: _passwordFormKey,
          child: MyTextField(
            validator: Validators.passwordTextValidator,
            hintText: 'Password',
            obscureText: true,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              password = value;
            },
          ),
        ),
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
              groupsValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
            const SizedBox(width: 10),
            MyCheckBox(
              label: 'Female',
              value: 'female',
              groupsValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 5),
        Validators.genderValidator(gender: gender, submitForm: isSubmit)
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
        'Sign Up',
        style: kSFBodyBold,
      ),
    );
  }

  Widget _buildSingUpBtn() {
    return Buttons.buildBtn(
      context: context,
      color: isLoading ? kGrey : kYellow,
      btnText: 'Sign Up',
      onPressed: isLoading ? null : submit,
    );
  }
}
