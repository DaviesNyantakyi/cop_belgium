import 'package:cop_belgium/utilities/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:regexpattern/regexpattern.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/screens/all_screens.dart';

class WelcomeScreen extends StatefulWidget {
  static String welcomeScreen = 'welcomeScreen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? email;
  String? password;
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> submit() async {
    FocusScope.of(context).unfocus();
    bool _validPassword = _passwordFormKey.currentState!.validate();
    bool validEmail = _emailFormKey.currentState!.validate();

    if (validEmail && _validPassword) {
      try {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }

        await EasyLoading.show(
          maskType: EasyLoadingMaskType.black,
          indicator: const CircularProgressIndicator(),
        );
        await Authentication().signIn(email: email, password: password);

        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        await EasyLoading.dismiss();
        kshowSnackbar(
          backgroundColor: kRedLight,
          context: context,
          child: Text(
            e.message.toString(),
            style: kSFBody.copyWith(color: Colors.black),
          ),
        );
      } finally {
        await EasyLoading.dismiss();
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogoText(),
                const SizedBox(height: 40),
                _buildForm(),
                const SizedBox(height: kButtonSpacing),
                _buildSignInBtn(),
                const SizedBox(height: kButtonSpacing),
                _buildAccountQuestion(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInBtn() {
    return Buttons.buildBtn(
      context: context,
      color: isLoading ? kGrey : kYellow,
      btnText: 'Sign In',
      onPressed: isLoading ? null : submit,
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        Form(
          key: _emailFormKey,
          child: MyTextField(
            hintText: 'Email',
            validator: Validators.emailTextValidator,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              email = value;
            },
            textInputAction: TextInputAction.next,
          ),
        ),
        const SizedBox(height: kTextFieldSpacing),
        Form(
          key: _passwordFormKey,
          child: MyTextField(
            validator: Validators.passwordTextValidator,
            hintText: 'Password',
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            textInputAction: TextInputAction.done,
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
            'assets/images/logos/logotest.jpg',
            width: 140.15,
            height: 140.15,
            filterQuality: FilterQuality.high,
          ),
        ),
        const SizedBox(height: 23),
        Text(
          'THE CHURCH OF',
          style: kSFCaptionBold.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        Text(
          'PENTECOST BELGIUM',
          style: kSFCaptionBold.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _buildAccountQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: kTextButtonStyle,
          child: Row(
            children: [
              const Text(
                'Not a member? ',
                style: kSFBody,
              ),
              Text(
                'Sing Up',
                style: kSFBodyBold.copyWith(color: kBlueLight),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
        ),
        TextButton(
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
      ],
    );
  }
}
