import 'package:cop_belgium/screens/auth_screens/login_screen.dart';
import 'package:cop_belgium/screens/auth_screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:cop_belgium/providers/signup_notifier.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';

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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: kBodyPadding),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(kBodyPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 44),
                  _buildEmailButton(),
                  const SizedBox(height: kContentSpacing12),
                  _buildLogInButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/logos/cop_logo.png',
      width: kCopLogoSize,
    );
  }

  Widget _buildLogInButton() {
    return Consumer<SignUpNotifier>(builder: (context, signUpProvider, _) {
      return Buttons.buildButton(
        context: context,
        btnText: 'Log in',
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
                  ChangeNotifierProvider<SignUpNotifier>.value(
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

  Widget _buildEmailButton() {
    return Buttons.buildSocialButton(
      context: context,
      icon: const Icon(
        FontAwesomeIcons.envelope,
        color: kBlack,
      ),
      label: const Text(
        'Continue with Email',
        style: kSFBtnStyleBold,
      ),
      onPressed: () {
        final signUpProvider =
            Provider.of<SignUpNotifier>(context, listen: false);

        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider<SignUpNotifier>.value(
                  value: signUpProvider,
                ),
              ],
              child: const SignUpScreen(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGoogleButton() {
    return Buttons.buildSocialButton(
      context: context,
      icon: const Icon(
        FontAwesomeIcons.google,
        color: kBlack,
      ),
      label: const Text(
        'Continue with Google',
        style: kSFBtnStyleBold,
      ),
      onPressed: () {
        final signUpProvider =
            Provider.of<SignUpNotifier>(context, listen: false);

        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider<SignUpNotifier>.value(
                  value: signUpProvider,
                ),
              ],
              child: const SignUpScreen(),
            ),
          ),
        );
      },
    );
  }
}
