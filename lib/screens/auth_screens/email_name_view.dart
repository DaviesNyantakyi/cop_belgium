import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/utilities/constant.dart';
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

    await Provider.of<PageController>(context, listen: false).nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutExpo,
    );
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
              _buildFirstName(),
              const SizedBox(height: kTextFieldSpacing),
              _buildLastName(),
              const SizedBox(height: kTextFieldSpacing),
              _buildEmail(),
              const SizedBox(height: kButtonSpacing),
              _buildContinueButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Buttons.buildButton(
      context: context,
      btnText: 'Continue',
      width: double.infinity,
      onPressed: onSubmit,
    );
  }

  Widget _buildEmail() {
    return MyTextField(
      controller: Provider.of<SignUpProvider>(context).emailCntlr,
      hintText: 'Email',
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onChanged: (value) {},
      onSubmitted: (value) async {
        await onSubmit();
      },
    );
  }

  Widget _buildLastName() {
    return MyTextField(
      controller: Provider.of<SignUpProvider>(context).lastNameCntlr,
      hintText: 'Last Name',
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
    );
  }

  Widget _buildFirstName() {
    return MyTextField(
      controller: Provider.of<SignUpProvider>(context).firstNameCntlr,
      hintText: 'First Name',
      textInputAction: TextInputAction.next,
      onChanged: (value) {},
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
