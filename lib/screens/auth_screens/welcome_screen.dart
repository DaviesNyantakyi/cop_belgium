import 'package:cop_belgium/services/podcast_service.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatefulWidget {
  static String welcomeScreen = 'welcomeScreen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController emailCntlr = TextEditingController();
  TextEditingController passwordCntlr = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;

  bool isLoading = false;
  bool showPassword = false;

  Future<void> loginEmail() async {
    FocusScope.of(context).unfocus();
    EasyLoading.show();
    try {
      isLoading = true;

      bool isValid = validateForm();

      if (isValid) {
        if (mounted) {
          setState(() {});
        }

        await FireAuth().login(
          email: emailCntlr.text,
          password: passwordCntlr.text,
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

  @override
  void dispose() {
    emailCntlr.dispose();
    passwordCntlr.dispose();

    super.dispose();
  }

  bool validateForm() {
    emailErrorText = Validators.emailValidator(
      email: emailCntlr.text,
    );
    passwordErrorText = Validators.passwordTextValidator(
      password: passwordCntlr.text,
    );

    if (emailErrorText == null && passwordErrorText == null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: kBodyPadding),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogoText(),
                const SizedBox(height: 54),
                _buildForm(),
                const SizedBox(height: kButtonSpacing),
                _buildLogInBtn(),
                const SizedBox(height: kButtonSpacing),
                _buildAccountQuestion(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogInBtn() {
    return Buttons.buildBtn(
      context: context,
      color: isLoading ? kGrey : kYellowDark,
      btnText: 'Log in',
      onPressed: isLoading ? null : loginEmail,
      width: double.infinity,
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
          style: kSFUnderline.copyWith(color: kRed),
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
          style: kSFUnderline.copyWith(color: kRed),
        )
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(height: kTextFieldSpacing),
        Container(
          alignment: Alignment.centerRight,
          child: TextButton(
            style: kTextButtonStyle,
            child: const Text(
              'Forgot Password?',
              style: kSFBody,
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ForgotPasswordScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLogoText() {
    return Column(
      children: [
        SizedBox(
          child: Image.asset(
            'assets/images/logos/cop_logo.jpg',
            width: 115,
            height: 115,
            filterQuality: FilterQuality.high,
          ),
        ),
      ],
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
              'Not a member? ',
              style: kSFBody,
            ),
          ),
          Flexible(
            child: Text(
              'Sign up',
              style: kSFBodyBold.copyWith(color: kBlueDark),
            ),
          ),
        ],
      ),
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());

        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const SignUpScreen()),
        );
      },
    );
  }
}
