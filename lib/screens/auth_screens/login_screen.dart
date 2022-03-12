import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:cop_belgium/services/fire_auth.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String loginScreen = 'loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final SignUpProvider _signUpProvider;

  @override
  void initState() {
    _signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    super.initState();
  }

  Future<void> loginEmail() async {
    FocusScope.of(context).unfocus();

    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);

    bool? validEmail = signUpProvider.emailKey.currentState?.validate();
    bool? validPassword = signUpProvider.passwordKey.currentState?.validate();

    try {
      signUpProvider.setLoading();

      if (validPassword == true && validEmail == true) {
        EasyLoading.show();
        await FireAuth().login(
          email: signUpProvider.emailCntlr.text,
          password: signUpProvider.passwordCntlr.text,
        );

        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      await EasyLoading.dismiss();
      kshowSnackbar(
        context: context,
        type: SnackBarType.error,
        text: e.message!,
      );
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      signUpProvider.setLoading();
      EasyLoading.dismiss();
    }
  }

  @override
  void dispose() {
    _signUpProvider.close();
    super.dispose();
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
            child: Consumer<SignUpProvider>(
              builder: (context, signUpProvider, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEmailForm(signUpProvider: signUpProvider),
                    const SizedBox(height: kContentSpacing8),
                    _buildPasswordForm(signUpProvider: signUpProvider),
                    const SizedBox(height: kContentSpacing8),
                    _buildForgotButton(signUpProvider: signUpProvider),
                    const SizedBox(height: kContentSpacing32),
                    _buildLogInBtn(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogInBtn() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
      return Buttons.buildButton(
        context: context,
        color: signUpProvider.isLoading ? kDisabledColor : kBlue,
        btnText: 'Log in',
        onPressed: signUpProvider.isLoading ? null : loginEmail,
        width: double.infinity,
        fontColor: Colors.white,
      );
    });
  }

  Widget _buildEmailForm({required SignUpProvider signUpProvider}) {
    return Form(
      key: signUpProvider.emailKey,
      child: MyTextFormField(
        controller: signUpProvider.emailCntlr,
        hintText: 'Email',
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: Validators.emailValidator,
        onChanged: (value) {
          signUpProvider.emailKey.currentState?.validate();
        },
      ),
    );
  }

  Widget _buildForgotButton({required SignUpProvider signUpProvider}) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: kTextButtonStyle,
        child: const Text(
          'Forgot Password?',
          style: kSFBody,
        ),
        onPressed: () {
          signUpProvider.close();
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
                  ChangeNotifierProvider<SignUpProvider>.value(
                value: signUpProvider,
                child: const ForgotPasswordScreen(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordForm({required SignUpProvider signUpProvider}) {
    return Form(
      key: signUpProvider.passwordKey,
      child: MyTextFormField(
        controller: signUpProvider.passwordCntlr,
        hintText: 'Password',
        maxLines: 1,
        obscureText: signUpProvider.viewPassword ? false : true,
        textInputAction: TextInputAction.done,
        validator: Validators.passwordValidator,
        suffixIcon: GestureDetector(
          child: Icon(
            signUpProvider.viewPassword
                ? Icons.visibility
                : Icons.visibility_off,
            color: kBlack,
          ),
          onTap: () {
            signUpProvider.togglePasswordView();
          },
        ),
        onChanged: (value) {
          signUpProvider.passwordKey.currentState?.validate();
        },
        onSubmitted: (value) async {
          await loginEmail();
        },
      ),
    );
  }
}
