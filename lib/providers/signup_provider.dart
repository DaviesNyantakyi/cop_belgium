import 'package:cop_belgium/utilities/validators.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  final TextEditingController _firstNameCntlr = TextEditingController();
  final TextEditingController _lastNameCntlr = TextEditingController();
  final TextEditingController _emailCntlr = TextEditingController();

  TextEditingController get firstNameCntlr => _firstNameCntlr;
  TextEditingController get lastNameCntlr => _lastNameCntlr;
  TextEditingController get emailCntlr => _emailCntlr;

  String? _firstNameErrorText;
  String? _lastNameErrorText;
  String? _emailErrorText;

  String? get firstNameErrorText => _firstNameErrorText;
  String? get lastNameErrorText => _lastNameErrorText;
  String? get emailErrorText => _emailErrorText;

  void setNameAndEmail({String? firstName, String? lastName, String? email}) {
    _firstNameCntlr.text = firstName ?? '';
    _lastNameCntlr.text = lastName ?? '';
    _emailCntlr.text = email ?? '';
    notifyListeners();
  }

  void validateEmail({String? email}) {
    _emailErrorText = Validators.emailValidator(email: email);
    notifyListeners();
  }

  void validateName({String? firstName, String? lastName}) {
    if (firstName != null) {
      _firstNameErrorText = Validators.nameValidator(firstName: firstName);
    }

    if (lastName != null) {
      _lastNameErrorText = Validators.nameValidator(lastName: lastName);
    }
    notifyListeners();
  }

  bool validEmailNameForm() {
    validateName(
      firstName: _firstNameCntlr.text,
      lastName: _lastNameCntlr.text,
    );
    validateEmail(email: _emailCntlr.text);

    if (_firstNameCntlr.text.isEmpty &&
        _lastNameCntlr.text.isEmpty &&
        emailCntlr.text.isEmpty) {
      return true;
    }
    return false;
  }

  void close() {
    _emailCntlr.text = '';
    _firstNameCntlr.text = '';
    _lastNameCntlr.text = '';
    _emailErrorText = null;
    _firstNameErrorText = null;
    _lastNameErrorText = null;
    notifyListeners();
  }
}
