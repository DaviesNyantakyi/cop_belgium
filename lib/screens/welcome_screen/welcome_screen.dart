import 'package:cop_belgium/screens/home_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 60),
                _buildTf(
                  inputLabel: 'Email',
                  hintText: 'JohnSmith@yourmail.com',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
                const SizedBox(height: 24),
                _buildTf(
                  inputLabel: 'Password',
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
                const SizedBox(height: 24),
                _buildBt(
                  btText: 'Sign In',
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      HomeScreen.homeScreen,
                    );
                  },
                ),
                const SizedBox(height: 19),
                _buildAccountQuestion(
                  onTapSingUp: () {
                    debugPrint('Sing in');
                  },
                  onTapForgotP: () {
                    debugPrint('Forgot Password');
                  },
                ),
                const SizedBox(height: 40),
                const Text('Or login with', style: kSFBody),
                const SizedBox(height: 24),
                _buildSocialBt(
                  onPressedGoogle: () {
                    Navigator.pushReplacementNamed(
                      context,
                      HomeScreen.homeScreen,
                    );
                  },
                  onPressedApple: () {
                    Navigator.pushReplacementNamed(
                      context,
                      HomeScreen.homeScreen,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBt({
    required VoidCallback onPressedGoogle,
    required VoidCallback onPressedApple,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: 'bt1',
          elevation: 1,
          backgroundColor: kBlueLight,
          child: Image.asset(
            'assets/images/logos/google.png',
            height: 28,
          ),
          onPressed: onPressedApple,
        ),
        const SizedBox(width: 16),
        FloatingActionButton(
          heroTag: 'bt2',
          elevation: 1,
          backgroundColor: kBlueLight,
          child: Image.asset(
            'assets/images/logos/apple.png',
            height: 28,
          ),
          onPressed: onPressedApple,
        ),
      ],
    );
  }

  Widget _buildAccountQuestion({
    required VoidCallback onTapForgotP,
    required VoidCallback onTapSingUp,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          splashColor: kBlueLight,
          child: Row(
            children: [
              const Text(
                'Not a Meber? ',
                style: kSFBody,
              ),
              Text(
                'Sing Up',
                style: kSFBodyBold.copyWith(color: kBlue),
              ),
            ],
          ),
          onTap: onTapSingUp,
        ),
        InkWell(
          splashColor: kBlueLight,
          child: const Text(
            'Forgot Password?',
            style: kSFBody,
          ),
          onTap: onTapForgotP,
        ),
      ],
    );
  }

  Widget _buildBt({required String btText, VoidCallback? onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kYellow),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          btText,
          style: kSFBodyBold,
        ),
      ),
    );
  }

  Widget _buildTf({
    required String inputLabel,
    required String hintText,
    required bool obscureText,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(
            inputLabel,
            style: kSFBody,
          ),
        ),
        _buildTF(
            hintText: hintText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            obscureText: obscureText),
      ],
    );
  }

  SizedBox _buildLogo() {
    return SizedBox(
      child: Image.asset(
        'assets/images/logos/cop_logo.png',
        width: 158.15,
        height: 158.15,
      ),
    );
  }

  Widget _buildTF({
    required String hintText,
    TextInputType? keyboardType,
    Function(String)? onChanged,
    required bool obscureText,
  }) {
    return TextField(
      style: kSFBody,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: kSFBody,
        fillColor: kBlueLight,
        border: InputBorder.none,
        focusColor: Colors.yellow,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
