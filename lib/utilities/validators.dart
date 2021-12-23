import 'package:flutter/material.dart';
import 'package:regexpattern/src/regex_extension.dart';

class Validators {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    // only letters
    if (!value.isAlphabet()) {
      return 'Name must contain only alphabetical characters.';
    }
  }

  static String? emailTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    if (!value.isEmail()) {
      return 'Please enter valid email address.';
    }
    return null;
  }

  static String? passwordTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password.';
    }

    if (!value.isPasswordEasy()) {
      return 'Password must contain at least 8 characters.';
    }
    return null;
  }

  static Widget genderValidator({String? gender, bool? submitForm}) {
    if (gender == null && submitForm == true) {
      return Text(
        'Please select your gender',
        style: TextStyle(color: Colors.red.shade700, fontSize: 13),
      );
    } else {
      return Container();
    }
  }
}
