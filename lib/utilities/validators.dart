import 'package:regexpattern/regexpattern.dart';

class Validators {
  static String? nameValidator({String? firstName, String? lastName}) {
    String? errorText;

    if (firstName != null) {
      if (firstName.isEmpty) {
        errorText = 'Enter your first name.';
      }
    }

    if (lastName != null) {
      if (lastName.isEmpty) {
        errorText = 'Enter your last name.';
      }
    }

    return errorText;
  }

  static String? emailValidator({String? email}) {
    String? errorText;
    if (email != null && email.isEmpty) {
      errorText = 'Enter your email address.';
    }
    return errorText;
  }

  static String? passwordTextValidator({String? password}) {
    if (password == null || password.isEmpty) {
      return 'Password must not be empty. ';
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
