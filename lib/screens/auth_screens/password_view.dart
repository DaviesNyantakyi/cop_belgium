import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({Key? key}) : super(key: key);

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool showPassField1 = false;
  bool showPassField2 = false;

  TextEditingController passField1Cntlr = TextEditingController();
  TextEditingController passField2Cntlr = TextEditingController();

  String? passField1ErrorText;
  String? passField2ErrorText;

  Future<void> onSubmit() async {
    // validate the fields
    bool isValid = validForm();
    if (isValid) {
      await Provider.of<PageController>(context, listen: false).nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutExpo,
      );
    }
  }

  bool validForm() {
    bool isValid = false;
    passField1ErrorText =
        Validators.passwordTextValidator(password: passField1Cntlr.text);
    passField2ErrorText =
        Validators.passwordTextValidator(password: passField2Cntlr.text);

    setState(() {});
    return isValid;
  }

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
                controller: passField1Cntlr,
                hintText: 'Password',
                obscureText: showPassField1 ? false : true,
                maxLines: 1,
                textInputAction: TextInputAction.next,
                suffixIcon: GestureDetector(
                  child: Icon(
                    showPassField1 ? Icons.visibility : Icons.visibility_off,
                    color: kBlack,
                  ),
                  onTap: () {
                    setState(() {
                      showPassField1 = !showPassField1;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              ErrorTextWidget(errorText: passField1ErrorText),
              const SizedBox(height: kTextFieldSpacing),
              MyTextField(
                controller: passField2Cntlr,
                hintText: 'Confirm Password',
                maxLines: 1,
                obscureText: showPassField2 ? false : true,
                textInputAction: TextInputAction.done,
                suffixIcon: GestureDetector(
                  child: Icon(
                    showPassField2 ? Icons.visibility : Icons.visibility_off,
                    color: kBlack,
                  ),
                  onTap: () {
                    setState(() {
                      showPassField2 = !showPassField2;
                    });
                  },
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) {},
              ),
              ErrorTextWidget(errorText: passField1ErrorText),
              const SizedBox(height: kButtonSpacing),
              Buttons.buildBtn(
                context: context,
                btnText: 'Continue',
                width: double.infinity,
                onPressed: () async {
                  await Provider.of<PageController>(context, listen: false)
                      .nextPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutExpo,
                  );
                },
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
      onPressed: () async {
        await Provider.of<PageController>(context, listen: false).previousPage(
          duration: kPagViewDuration,
          curve: kPagViewCurve,
        );
      },
    );
  }

  Widget _buildPasswordText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Choose a password',
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
