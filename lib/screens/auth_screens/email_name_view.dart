import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
import 'package:flutter/material.dart';

class EmailNameView extends StatefulWidget {
  const EmailNameView({Key? key}) : super(key: key);

  @override
  State<EmailNameView> createState() => _EmailNameViewState();
}

class _EmailNameViewState extends State<EmailNameView> {
  TextEditingController firstNameCntlr = TextEditingController();
  TextEditingController lasntNameCntlr = TextEditingController();
  TextEditingController emailCntlr = TextEditingController();

  String? firstNameErrorText;
  String? lastNameErrorText;
  String? emailErrorText;
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
              _buildEmailText(),
              const SizedBox(height: kButtonSpacing),
              MyTextField(
                controller: firstNameCntlr,
                hintText: 'First Name',
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              ErrorTextWidget(errorText: firstNameErrorText),
              const SizedBox(height: kTextFieldSpacing),
              MyTextField(
                controller: lasntNameCntlr,
                hintText: 'Last Name',
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              ErrorTextWidget(errorText: lastNameErrorText),
              const SizedBox(height: kTextFieldSpacing),
              MyTextField(
                controller: emailCntlr,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  emailErrorText = Validators.emailValidator(email: value);
                  setState(() {});
                },
                onSubmitted: (value) {},
              ),
              ErrorTextWidget(errorText: emailErrorText),
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

  Widget _buildEmailText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Please enter your name',
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
