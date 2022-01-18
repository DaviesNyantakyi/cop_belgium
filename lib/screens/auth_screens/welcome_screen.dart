import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/easy_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Future<void> loginEmail() async {
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
        await EaslyLoadingIndicator.showLoading();
        await Authentication().signIn(email: email, password: password);

        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        await EaslyLoadingIndicator.dismissLoading();
        kshowSnackbar(
          errorType: 'error',
          context: context,
          text: e.message.toString(),
        );
      } finally {
        await EaslyLoadingIndicator.dismissLoading();
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailFormKey.currentState?.dispose();
    _passwordFormKey.currentState?.dispose();
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

  Widget _buildLogInBtn() {
    return Buttons.buildBtn(
      context: context,
      color: isLoading ? kGrey : kYellow,
      btnText: 'Log in',
      onPressed: isLoading ? null : loginEmail,
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
              FocusScope.of(context).unfocus();
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
              'Sing Up',
              style: kSFBodyBold.copyWith(color: kBlueDark),
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const SignUpScreen()),
        );
        FocusScope.of(context).unfocus();
      },
    );
  }
}
