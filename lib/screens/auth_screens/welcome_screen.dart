import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:provider/provider.dart';

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
        padding: const EdgeInsets.symmetric(vertical: kBodyPadding),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kBodyPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                _buildLogo(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                _buildSocialButtons(),
                const SizedBox(height: kButtonSpacing),
                _buildDivderText(),
                const SizedBox(height: kButtonSpacing),
                _buildLogInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/logos/cop_logo.jpg',
      width: 120,
    );
  }

  Widget _buildSocialButtons() {
    return Column(
      children: [
        Buttons.buildSocialBtn(
          context: context,
          icon: const Icon(
            Icons.email_outlined,
            color: kBlack,
          ),
          label: const Text(
            'Continue with Email',
            style: kSFBtnStyleBold,
          ),
          onPressed: () {
            final signUpProvider =
                Provider.of<SignUpProvider>(context, listen: false);
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                  value: signUpProvider,
                  child: const SignUpScreen(),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: kTextFieldSpacing),
        Buttons.buildSocialBtn(
          context: context,
          icon: Image.asset(
            'assets/images/logos/google.png',
            width: kIconSize,
          ),
          label: const Text(
            'Continue with Google',
            style: kSFBtnStyleBold,
          ),
          onPressed: () {},
        ),
        const SizedBox(height: kTextFieldSpacing),
        Buttons.buildSocialBtn(
          context: context,
          icon: Image.asset(
            'assets/images/logos/apple.png',
            width: kIconSize,
          ),
          label: const Text(
            'Continue with Apple',
            style: kSFBtnStyleBold,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildLogInButton() {
    return Buttons.buildBtn(
      context: context,
      btnText: 'Log in',
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
      width: double.infinity,
      fontColor: Colors.white,
    );
  }

  Widget _buildDivderText() {
    double dividerWidth = 100;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: dividerWidth,
          child: const Divider(color: kBlack),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            'OR',
            style: kSFBodyBold.copyWith(color: kBlack),
          ),
        ),
        SizedBox(
          width: dividerWidth,
          child: const Divider(color: kBlack),
        ),
      ],
    );
  }
}
