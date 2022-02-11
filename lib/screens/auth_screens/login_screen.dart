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

class LoginScreen extends StatefulWidget {
  static String loginScreen = 'loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCntlr = TextEditingController();
  TextEditingController passwordCntlr = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;

  bool isLoading = false;
  bool showPassword = false;

  Future<void> loginEmail() async {
    FocusScope.of(context).unfocus();

    try {
      isLoading = true;

      bool isValid = validateForm();

      if (isValid) {
        EasyLoading.show();
        await FireAuth().login(
          email: emailCntlr.text,
          password: passwordCntlr.text,
        );

        Navigator.pop(context);
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
    emailErrorText = Validators.emailValidator(email: emailCntlr.text);
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
      appBar: AppBar(
        leading: kBackButton(context: context),
        title: const Text('Login', style: kSFHeadLine3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: kBodyPadding),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kBodyPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildForm(),
                const SizedBox(height: kButtonSpacing),
                _buildLogInBtn(),
                const SizedBox(height: kButtonSpacing),
                _buildDivderText(),
                const SizedBox(height: kButtonSpacing),
                _buildSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Column(
      children: [
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

  Widget _buildLogInBtn() {
    return Buttons.buildBtn(
      context: context,
      color: isLoading ? kDisabledColor : kBlue,
      btnText: 'Log in',
      onPressed: isLoading ? null : loginEmail,
      width: double.infinity,
      fontColor: Colors.white,
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
        ErrorTextWidget(errorText: emailErrorText),
        const SizedBox(height: kTextFieldSpacing),
        MyTextField(
          controller: passwordCntlr,
          hintText: 'Password',
          obscureText: showPassword ? false : true,
          textInputAction: TextInputAction.done,
          suffixIcon: GestureDetector(
            child: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: kBlack,
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
          onSubmitted: (value) async {
            await loginEmail();
          },
        ),
        ErrorTextWidget(errorText: passwordErrorText),
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
