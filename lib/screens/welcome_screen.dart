import 'package:cop_belgium/utilities/colors.dart';
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
                _buildTextForm(
                  inputLabel: 'Email',
                  hintText: 'JohnSmith@yourmail.com',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
                const SizedBox(height: 24),
                _buildTextForm(
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
                    debugPrint('Sing in');
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
                const Text('Or login with', style: kSFNormal),
                const SizedBox(height: 24),
                _buildSocialBt(
                  onPressedGoogle: () {},
                  onPressedApple: () {},
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
                style: kSFNormal,
              ),
              Text(
                'Sing Up',
                style: kSFNormalBold.copyWith(color: kBlue),
              ),
            ],
          ),
          onTap: onTapSingUp,
        ),
        InkWell(
          splashColor: kBlueLight,
          child: const Text(
            'Forgot Password?',
            style: kSFNormal,
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
          style: kSFNormalBold,
        ),
      ),
    );
  }

  Widget _buildTextForm({
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
            style: kSFNormal,
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
      style: kSFNormal,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: kSFNormal,
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
