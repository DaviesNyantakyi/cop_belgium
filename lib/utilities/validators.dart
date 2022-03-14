import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:regexpattern/regexpattern.dart';

class Validators {
  static String noServiceTimeErrorMessage = 'Add one or more service times';
  static String? textValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Field required';
    }
    return null;
  }

  static String? nameValidator(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == null ||
        email.isEmpty ||
        !email.contains('@') ||
        !email.contains('.')) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? passwordValidator(String? password) {
    if (!password!.isPasswordEasy() || password.isEmpty) {
      return 'Password must contain at least 8 characters';
    }
    return null;
  }

  static String? phoneNumberValidator(String? phoneNumber) {
    if (!phoneNumber!.isPhone() || phoneNumber.isEmpty) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? genderValidator({String? gender}) {
    if (gender != null && gender.isEmpty) {
      return 'Select your gender';
    }
    return null;
  }

  static String? birthdayValidator({DateTime? date}) {
    if (date == null) {
      return 'Select your date of birth';
    }

    return null;
  }

  Widget showValidationWidget({String? errorText}) {
    if (errorText == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        errorText,
        style: kSFBody2.copyWith(color: kRed),
      ),
    );
  }
}
