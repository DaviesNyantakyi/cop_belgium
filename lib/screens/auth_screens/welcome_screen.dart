import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/screens/auth_screens/widgets/social_signup_buttons.dart';
import 'package:cop_belgium/providers/image_selector_provider.dart';
import 'package:cop_belgium/widgets/church_logo.dart';
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
                const BuildCopLogo(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                _buildSocialButtons(),
                const SizedBox(height: kContentSpacing32),
                _buildDivderText(),
                const SizedBox(height: kContentSpacing32),
                _buildLogInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogInButton() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
      return Buttons.buildButton(
        context: context,
        btnText: 'Log in',
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
                  ChangeNotifierProvider<SignUpProvider>.value(
                value: signUpProvider,
                child: const LoginScreen(),
              ),
            ),
          );
        },
        width: double.infinity,
        fontColor: Colors.white,
      );
    });
  }

  Widget _buildSocialButtons() {
    return Column(
      children: [
        Buttons.buildSocialButton(
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
            final imageSelector =
                Provider.of<ImagePickerProvider>(context, listen: false);
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<SignUpProvider>.value(
                      value: signUpProvider,
                    ),
                    ChangeNotifierProvider<ImagePickerProvider>.value(
                      value: imageSelector,
                    )
                  ],
                  child: const SignUpScreen(),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: kContentSpacing12),
        const BuildSocialSignupButtons()
      ],
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
