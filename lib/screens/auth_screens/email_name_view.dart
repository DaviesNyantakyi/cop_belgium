import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailNameView extends StatefulWidget {
  const EmailNameView({Key? key}) : super(key: key);

  @override
  State<EmailNameView> createState() => _EmailNameViewState();
}

class _EmailNameViewState extends State<EmailNameView> {
  Future<void> onSubmit() async {
    FocusScope.of(context).unfocus();

    validForm();

    await Provider.of<PageController>(context, listen: false).nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutExpo,
    );
  }

  bool validForm() {
    bool isValid = false;

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kBackButton(context: context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInstuctionText(),
              const SizedBox(height: kButtonSpacing),
              MyTextField(
                controller: Provider.of<SignUpProvider>(context).firstNameCntlr,
                hintText: 'First Name',
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  Provider.of<SignUpProvider>(context, listen: false)
                      .validateName(firstName: value);
                },
              ),
              ErrorTextWidget(
                errorText:
                    Provider.of<SignUpProvider>(context).firstNameErrorText,
              ),
              const SizedBox(height: kTextFieldSpacing),
              MyTextField(
                controller: Provider.of<SignUpProvider>(context).lastNameCntlr,
                hintText: 'Last Name',
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  Provider.of<SignUpProvider>(context, listen: false)
                      .validateName(lastName: value);
                },
              ),
              ErrorTextWidget(
                errorText:
                    Provider.of<SignUpProvider>(context).lastNameErrorText,
              ),
              const SizedBox(height: kTextFieldSpacing),
              MyTextField(
                controller: Provider.of<SignUpProvider>(context).emailCntlr,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  Provider.of<SignUpProvider>(context, listen: false)
                      .validateEmail(email: value);
                },
                onSubmitted: (value) async {
                  await onSubmit();
                },
              ),
              ErrorTextWidget(
                errorText: Provider.of<SignUpProvider>(context).emailErrorText,
              ),
              const SizedBox(height: kButtonSpacing),
              Buttons.buildButton(
                context: context,
                btnText: 'Continue',
                width: double.infinity,
                onPressed: onSubmit,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstuctionText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Enter your name',
          style: kSFHeadLine2,
        ),
        Text(
          'and email.',
          style: kSFHeadLine2,
        ),
      ],
    );
  }
}
