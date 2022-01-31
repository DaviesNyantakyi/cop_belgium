import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({Key? key}) : super(key: key);

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool showPasswordField1 = false;
  bool showPasswordField2 = false;

  TextEditingController passwordField1Cntlr = TextEditingController();
  TextEditingController passwordField2Cntlr = TextEditingController();

  String? passwordField1ErrorText;
  String? passwordField2ErrorText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _backButton(context: context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPasswordText(),
              const SizedBox(
                height: kButtonSpacing,
              ),
              MyTextField(
                controller: passwordField1Cntlr,
                hintText: 'Password',
                obscureText: showPasswordField1 ? false : true,
                textInputAction: TextInputAction.next,
                suffixIcon: GestureDetector(
                  child: Icon(
                    showPasswordField1
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: kBlack,
                  ),
                  onTap: () {
                    setState(() {
                      showPasswordField1 = !showPasswordField1;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              ErrorTextWidget(errorText: passwordField1ErrorText),
              const SizedBox(height: kTextFieldSpacing),
              MyTextField(
                controller: passwordField2Cntlr,
                hintText: 'Confirm Password',
                obscureText: showPasswordField2 ? false : true,
                textInputAction: TextInputAction.done,
                suffixIcon: GestureDetector(
                  child: Icon(
                    showPasswordField2
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: kBlack,
                  ),
                  onTap: () {
                    setState(() {
                      showPasswordField2 = !showPasswordField2;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) {},
              ),
              ErrorTextWidget(errorText: passwordField1ErrorText),
              const SizedBox(height: kButtonSpacing),
              Buttons.buildBtn(
                context: context,
                btnText: 'Continue',
                width: double.infinity,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic _backButton({required BuildContext context}) {
    return TextButton(
      style: kTextButtonStyle,
      child: const Icon(
        Icons.chevron_left,
        color: kBlack,
        size: 40,
      ),
      onPressed: () {},
    );
  }

  Widget _buildPasswordText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Please choose a',
          style: kSFHeadLine2,
        ),
        Text(
          'password.',
          style: kSFHeadLine2,
        ),
        Text(
          'Password must be a least 8 characters',
          style: kSFBody,
        ),
      ],
    );
  }
}
