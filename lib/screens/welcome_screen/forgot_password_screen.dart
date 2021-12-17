import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String forgotPasswordScreen = 'forgotPasswordScreen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                MyTextField.buildTF(
                  label: 'Email',
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
                const SizedBox(height: kButtonSpacing),
                _buildSendBtn(),
              ],
            ),
          ),
        ),
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
          'Don\'t worry! It happens. Please enter the email address associated with yout account.',
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
          backgroundColor: MaterialStateProperty.all(kYellow),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kButtonRadius),
              ),
            ),
          ),
        ),
        onPressed: () async {
          _showMailConformationAlert();
        },
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
            child: const Text('OK', style: kSFCaptionBold),
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
            color: kDarkBlue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
