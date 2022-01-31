import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

class Validators {
  static String? normalValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Text field must not be empty.';
    }
  }

  static String? nameValidator({String? firstName, String? lastName}) {
    String? errorText;
    if (firstName != null && firstName.isEmpty ||
        lastName != null && lastName.isEmpty) {
      errorText = 'Please enter your first and last name.';
    }

    return errorText;
  }

  static String? emailValidator({String? email}) {
    String? errorText;
    if (email != null && email.isEmpty) {
      errorText = 'Please enter your email address.';
    }

    return errorText;
  }

  static String? passwordTextValidator({String? password}) {
    if (password == null || password.isEmpty) {
      return 'Please enter password.';
    }

    if (!password.isPasswordEasy()) {
      return 'Password must contain at least 8 characters.';
    }
    return null;
  }

  static String? genderValidator({String? gender}) {
    String? errorText;
    if (gender != null && gender.isEmpty) {
      errorText = 'Please select your gender.';
    }
    return errorText;
  }

  static String? birthdayValidator({DateTime? date}) {
    String? errorText;
    if (date == null) {
      errorText = 'Please select your date of birth.';
    }

    return errorText;
  }
}

class ErrorTextWidget extends StatelessWidget {
  final String? errorText;
  const ErrorTextWidget({Key? key, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (errorText == null) {
      return Container();
    }
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          errorText!,
          style: kSFCaption.copyWith(color: kRed),
        )
      ],
    );
  }
}
