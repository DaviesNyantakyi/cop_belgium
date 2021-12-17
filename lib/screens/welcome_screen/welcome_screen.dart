import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cop_belgium/screens/home_screen.dart';
import 'package:cop_belgium/screens/welcome_screen/forgot_password_screen.dart';
import 'package:cop_belgium/screens/welcome_screen/sign_up_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';

class WelcomeScreen extends StatefulWidget {
  static String welcomeScreen = 'welcomeScreen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                _buildLogo(),
                const SizedBox(height: 40),
                MyTextField.buildTF(
                  label: 'Email',
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
                const SizedBox(height: kTextFieldSpacing),
                MyTextField.buildTF(
                  label: 'Password',
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
                const SizedBox(height: kButtonSpacing),
                Buttons.buildBtn(
                  context: context,
                  color: kYellow,
                  btnText: 'Sign In',
                  onPressed: () {},
                ),
                const SizedBox(height: kButtonSpacing),
                _buildAccountQuestion(),
                const SizedBox(height: 24),
                const Text('Or continue with', style: kSFBody),
                const SizedBox(height: 24),
                _buildSocialBtns()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        SizedBox(
          child: Image.asset(
            'assets/images/logos/cop_logo.png',
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
            Navigator.pushNamed(context, SignUpScreen.signUpScreen);
          },
        ),
        TextButton(
          style: kTextButtonStyle,
          child: const Text(
            'Forgot Password?',
            style: kSFBody,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              ForgotPasswordScreen.forgotPasswordScreen,
            );
          },
        ),
      ],
    );
  }

  Widget _buildSocialBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: 'bt1',
          elevation: 1,
          backgroundColor: kBlueLight2,
          child: Image.asset(
            'assets/images/logos/google.png',
            height: 28,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              HomeScreen.homeScreen,
            );
          },
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'bt2',
          elevation: 1,
          backgroundColor: kBlueLight2,
          child: Image.asset(
            'assets/images/logos/apple.png',
            height: 28,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              HomeScreen.homeScreen,
            );
          },
        ),
      ],
    );
  }
}
