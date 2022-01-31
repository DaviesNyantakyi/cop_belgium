import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/textfiel.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String forgotPasswordScreen = 'forgotPasswordScreen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isLoading = false;
  TextEditingController emailCntlr = TextEditingController();
  String? emailErrorText;

  Future<void> resetPassword() async {
    FocusScope.of(context).unfocus();
    EasyLoading.show();
    try {
      isLoading = true;

      bool isValid = validateForm();

      if (isValid) {
        setState(() {});

        await FireAuth().sendResetPassword(email: emailCntlr.text);
        _showMailConformationAlert();
      }

      setState(() {});
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
      setState(() {});
    }
  }

  bool validateForm() {
    emailErrorText = Validators.emailValidator(email: emailCntlr.text);

    if (emailErrorText == null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kBackButton(context: context),
        title: const Text('Forgot Password', style: kSFHeadLine3),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kBodyPadding,
              vertical: kBodyPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildForgotPassText(),
                const SizedBox(height: 39),
                _buildEmailForm(),
                const SizedBox(height: kButtonSpacing),
                _buildSendButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextField(
          controller: emailCntlr,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            emailErrorText = Validators.emailValidator(email: value);
            setState(() {});
          },
          onSubmitted: (value) async {
            await resetPassword();
          },
        ),
        ErrorTextWidget(errorText: emailErrorText)
      ],
    );
  }

  Widget _buildForgotPassText() {
    return const Text(
      'Please enter the email address associated with your account.',
      style: kSFBody,
    );
  }

  Widget _buildSendButton() {
    return Buttons.buildBtn(
      context: context,
      color: isLoading ? kGrey : kBlue,
      btnText: 'Send',
      onPressed: isLoading ? null : resetPassword,
      width: double.infinity,
      fontColor: Colors.white,
    );
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
            child: const Text('OK', style: kSFCaptionBold),
          ),
        ],
      ),
    );
  }
}
