import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:regexpattern/regexpattern.dart';

class Validators {
  static String noServiceTime = 'Service time required';
  static String? textValidator(String? vaue) {
    if (vaue == null || vaue.isEmpty) {
      return 'Field required';
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email == null ||
        email.isEmpty ||
        !email.contains('@') ||
        !email.contains('.')) {
      return 'Email not valid';
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
      return 'Phone number must start with 0 or +';
    }
    return null;
  }

  static String? genderValidator({String? gender}) {
    if (gender != null && gender.isEmpty) {
      return 'Gender required';
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
