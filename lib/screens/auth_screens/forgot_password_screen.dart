import 'package:cop_belgium/services/firebase_auth.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:regexpattern/regexpattern.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String forgotPasswordScreen = 'forgotPasswordScreen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? email;
  bool isLoading = false;

  final _emailFormKey = GlobalKey<FormState>();

  Future<void> submit() async {
    bool validEmail = _emailFormKey.currentState!.validate();

    if (validEmail) {
      try {
        if (mounted) {
          setState(() {
            isLoading = true;
          });
        }

        await EasyLoading.show(
          maskType: EasyLoadingMaskType.black,
          indicator: const CircularProgressIndicator(
            color: Colors.white,
          ),
        );

        await Authentication().sendResetPassword(email: email);

        FocusScope.of(context).unfocus();
        _showMailConformationAlert();
      } on FirebaseAuthException catch (e) {
        kshowSnackbar(
          errorType: 'error',
          context: context,
          text: e.message.toString(),
        );
      } on FirebaseException catch (e) {
        kshowSnackbar(
          errorType: 'error',
          context: context,
          text: e.message.toString(),
        );
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        if (mounted) {
          await EasyLoading.dismiss();
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
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
                _buildFrgPassText(),
                const SizedBox(height: 29),
                _buildEmailForm(),
                const SizedBox(height: kButtonSpacing),
                _buildSendBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    return Form(
      key: _emailFormKey,
      child: MyTextField(
        hintText: 'Email',
        obscureText: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter email';
          }
          if (!value.isEmail()) {
            return 'Please enter valid email address';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          email = value;
        },
      ),
    );
  }

  Widget _buildFrgPassText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Forgot',
              style: kSFHeadLine1,
            ),
            Text(
              'Password',
              style: kSFHeadLine1,
            ),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          'Don\'t worry! It happens. Please enter the email address associated with your account.',
          style: kSFBody,
        ),
      ],
    );
  }

  Widget _buildSendBtn() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isLoading ? kGrey : kYellow,
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: isLoading ? null : submit,
        child: const Text(
          'Send',
          style: kSFBodyBold,
        ),
      ),
    );
  }

  Future<String?> _showMailConformationAlert() async {
    return await showDialog<String?>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
        ),
        title: const Text(
          'Check your mail',
          style: kSFHeadLine2,
        ),
        content: const Text(
            'We have sent password recovery instructions to your email.',
            style: kSFBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: const Text('Ok', style: kSFCaptionBold),
          ),
        ],
      ),
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: kBlueDark,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
