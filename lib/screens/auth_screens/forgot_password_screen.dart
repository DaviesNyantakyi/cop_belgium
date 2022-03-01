import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String forgotPasswordScreen = 'forgotPasswordScreen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  TextEditingController emailCntlr = TextEditingController();
  Future<void> resetPassword() async {
    FocusScope.of(context).unfocus();

    try {
      bool? isValid = emailKey.currentState?.validate();

      Provider.of<SignUpProvider>(context, listen: false).setLoading();

      if (isValid == true) {
        EasyLoading.show();
        await FireAuth().sendResetPassword(email: emailCntlr.text);
        _showMailConformationAlert();
      }
    } on FirebaseAuthException catch (e) {
      await EasyLoading.dismiss();
      kshowSnackbar(
        context: context,
        type: 'error',
        text: e.message!,
      );
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Provider.of<SignUpProvider>(context, listen: false).setLoading();

      EasyLoading.dismiss();
    }
  }

  @override
  void dispose() {
    emailKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kBackButton(context: context),
        title: const Text('Forgot Password', style: kSFHeadLine3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kBodyPadding),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildForgotPassText(),
              const SizedBox(height: 39),
              _buildEmailForm(),
              const SizedBox(height: kContentSpacing32),
              _buildSendButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: emailKey,
            child: MyTextFormField(
              controller: emailCntlr,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: Validators.emailValidator,
              onChanged: (value) {
                emailKey.currentState?.validate();
              },
              onSubmitted: (value) async {
                await resetPassword();
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildForgotPassText() {
    return const Text(
      'Please enter the email address associated with your account.',
      style: kSFBody,
    );
  }

  Widget _buildSendButton() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
      return Buttons.buildButton(
        context: context,
        color: signUpProvider.isLoading ? kDisabledColor : kBlue,
        btnText: 'Send',
        onPressed: signUpProvider.isLoading ? null : resetPassword,
        width: double.infinity,
        fontColor: Colors.white,
      );
    });
  }

  Future<String?> _showMailConformationAlert() async {
    return await showDialog<String?>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
        ),
        title: const Text(
          'Check your mail',
          style: kSFBodyBold,
        ),
        content: const Text(
            'We have sent password recovery instructions to your email.',
            style: kSFBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: kSFBody2Bold),
          ),
        ],
      ),
    );
  }
}
