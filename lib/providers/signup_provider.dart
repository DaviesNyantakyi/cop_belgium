import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  final TextEditingController _firstNameCntlr = TextEditingController();
  final TextEditingController _lastNameCntlr = TextEditingController();
  final TextEditingController _emailCntlr = TextEditingController();
  final TextEditingController _passwordCntlr = TextEditingController();
  final TextEditingController _passwordConformationCntlr =
      TextEditingController();

  TextEditingController get firstNameCntlr => _firstNameCntlr;
  TextEditingController get lastNameCntlr => _lastNameCntlr;
  TextEditingController get emailCntlr => _emailCntlr;
  TextEditingController get passwordCntlr => _passwordCntlr;
  TextEditingController get passwordConformationCntlr =>
      _passwordConformationCntlr;

  void setNameAndEmail({String? firstName, String? lastName, String? email}) {
    _firstNameCntlr.text = firstName ?? '';
    _lastNameCntlr.text = lastName ?? '';
    _emailCntlr.text = email ?? '';
    notifyListeners();
  }

  void close() {
    _emailCntlr.text = '';
    _firstNameCntlr.text = '';
    _lastNameCntlr.text = '';
    notifyListeners();
  }
}
