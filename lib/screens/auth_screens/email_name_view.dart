import 'package:cop_belgium/providers/signup_provider.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/validators.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:cop_belgium/widgets/snackbar.dart';
import 'package:cop_belgium/widgets/textfiel.dart';
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
          Provider.of<SignUpProvider>(context, listen: false);
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
        type: 'error',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderText(),
              const SizedBox(height: kContentSpacing32),
              _buildFirstName(),
              const SizedBox(height: kContentSpacing12),
              _buildLastName(),
              const SizedBox(height: kContentSpacing12),
              _buildEmail(),
              const SizedBox(height: kContentSpacing12),
              _buildPasswordField(),
              const SizedBox(height: kContentSpacing32),
              _buildContinueButton()
            ],
          ),
        ),
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
          'Create an account by singing up with your email address.',
          style: kSFBody,
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
      return Form(
        key: signUpProvider.emailKey,
        child: MyTextFormField(
          controller: signUpProvider.emailCntlr,
          hintText: 'Email',
          textInputAction: TextInputAction.next,
          maxLines: 1,
          validator: Validators.emailValidator,
          onChanged: (value) {
            signUpProvider.emailKey.currentState?.validate();
          },
        ),
      );
    });
  }

  Widget _buildLastName() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
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

  Widget _buildFirstName() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
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

  Widget _buildPasswordField() {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
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
}
