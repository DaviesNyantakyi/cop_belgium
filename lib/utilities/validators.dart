import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:regexpattern/regexpattern.dart';

class Validators {
  static String? nameValidator(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return 'Enter your name.';
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == null ||
        email.isEmpty ||
        !email.contains('@') ||
        !email.contains('.')) {
      return 'Enter a valid email address.';
    }

    return null;
  }

  static String? passwordValidator(String? password) {
    if (!password!.isPasswordEasy() || password.isEmpty) {
      return 'Password must contain at least 8 characters.';
    }
    return null;
  }

  static String? genderValidator({String? gender}) {
    if (gender != null && gender.isEmpty) {
      return 'Please select your gender.';
    }
    return null;
  }

  static String? birthdayValidator({DateTime? date}) {
    if (date == null) {
      return 'Please select your date of birth.';
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
