import 'package:cop_belgium/providers/signup_notifier.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailNamePasswordView extends StatefulWidget {
  const EmailNamePasswordView({Key? key}) : super(key: key);

  @override
  State<EmailNamePasswordView> createState() => _EmailNamePasswordViewState();
}

class _EmailNamePasswordViewState extends State<EmailNamePasswordView> {
  Future<void> onSubmit() async {
    FocusScope.of(context).unfocus();

    bool hasConnection = await ConnectionChecker().checkConnection();
    if (hasConnection) {
      final signUpProvider =
          Provider.of<SignUpNotifier>(context, listen: false);
      final bool? validEmail = signUpProvider.emailKey.currentState?.validate();
      final bool? validFirstName =
          signUpProvider.firstNameKey.currentState?.validate();
      final bool? validLastName =
          signUpProvider.lastNameKey.currentState?.validate();
      final bool? validPasswordField =
          signUpProvider.passwordKey.currentState?.validate();

      if (validEmail == true &&
          validFirstName == true &&
          validLastName == true &&
          validPasswordField == true) {
        if (signUpProvider.viewPassword == true &&
            signUpProvider.viewPassword == true) {
          // Hiding the password befor navigating to the next page
          signUpProvider.togglePasswordView();
        }
        await Provider.of<PageController>(context, listen: false).nextPage(
          duration: kPagViewDuration,
          curve: kPagViewCurve,
        );
      }
    } else {
      kshowSnackbar(
        context: context,
        type: SnackBarType.error,
        text: ConnectionChecker.connectionException.message!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kBackButton(context: context),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(kBodyPadding),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeaderText(),
                  const SizedBox(height: kContentSpacing32),
                  _buildFirstNameField(),
                  const SizedBox(height: kContentSpacing8),
                  _buildLastNameField(),
                  const SizedBox(height: kContentSpacing8),
                  _buildEmailField(),
                  const SizedBox(height: kContentSpacing8),
                  _buildPasswordField(),
                  const SizedBox(height: kContentSpacing32),
                  _buildContinueButton(),
                  const SizedBox(height: kContentSpacing32),
                  _buildPolicyText()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Sign up with your',
          style: kSFHeadLine2,
        ),
        Text(
          'email',
          style: kSFHeadLine2,
        ),
        Text(
          'Enter your Name, Email, and Password for sign up',
          style: kSFBody,
        ),
      ],
    );
  }

  Widget _buildFirstNameField() {
    return Consumer<SignUpNotifier>(builder: (context, signUpProvider, _) {
      return Form(
        key: signUpProvider.firstNameKey,
        child: MyTextFormField(
          controller: signUpProvider.firstNameCntlr,
          hintText: 'First Name',
          textInputAction: TextInputAction.next,
          maxLines: 1,
          validator: Validators.nameValidator,
          onChanged: (value) {
            signUpProvider.firstNameKey.currentState?.validate();
          },
        ),
      );
    });
  }

  Widget _buildLastNameField() {
    return Consumer<SignUpNotifier>(builder: (context, signUpProvider, _) {
      return Form(
        key: signUpProvider.lastNameKey,
        child: MyTextFormField(
          controller: signUpProvider.lastNameCntlr,
          hintText: 'Last Name',
          textInputAction: TextInputAction.next,
          validator: Validators.nameValidator,
          maxLines: 1,
          onChanged: (value) {
            signUpProvider.lastNameKey.currentState?.validate();
          },
        ),
      );
    });
  }

  Widget _buildEmailField() {
    return Consumer<SignUpNotifier>(builder: (context, signUpProvider, _) {
      return Form(
        key: signUpProvider.emailKey,
        child: MyTextFormField(
          controller: signUpProvider.emailCntlr,
          hintText: 'Email',
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          validator: Validators.emailValidator,
          onChanged: (value) {
            signUpProvider.emailKey.currentState?.validate();
          },
        ),
      );
    });
  }

  Widget _buildPasswordField() {
    return Consumer<SignUpNotifier>(builder: (context, signUpProvider, _) {
      bool viewPassword = signUpProvider.viewPassword ? false : true;

      return Form(
        key: signUpProvider.passwordKey,
        child: MyTextFormField(
          controller: signUpProvider.passwordCntlr,
          hintText: 'Password',
          textInputAction: TextInputAction.done,
          validator: Validators.passwordValidator,
          obscureText: viewPassword,
          maxLines: 1,
          onChanged: (value) {
            signUpProvider.passwordKey.currentState?.validate();
          },
          onSubmitted: (value) async {
            await onSubmit();
          },
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
        ),
      );
    });
  }

  Widget _buildContinueButton() {
    return Buttons.buildButton(
      context: context,
      btnText: 'Continue',
      width: double.infinity,
      onPressed: onSubmit,
    );
  }

  Widget _buildPolicyText() {
    return Column(
      children: [
        const Text(
          'By creating an account, you agree to the ',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: const Text(
                'Privacy Policy',
                style: TextStyle(fontWeight: FontWeight.bold, color: kBlue),
              ),
              onTap: () {
                loadMdFile(
                  context: context,
                  mdFile: 'assets/privacy/privacy_policy.md',
                );
              },
            ),
            const Text(
              ' and',
            ),
            InkWell(
              child: const Text(
                ' Terms of Conditions',
                style: TextStyle(fontWeight: FontWeight.bold, color: kBlue),
              ),
              onTap: () {
                loadMdFile(
                  context: context,
                  mdFile: 'assets/privacy/terms_of_service.md',
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
