import 'dart:io';

import 'package:cop_belgium/models/user_model.dart';

import 'package:flutter/material.dart';

import '../services/fire_auth.dart';
import '../services/fire_storage.dart';

class SignUpProvider extends ChangeNotifier {
  final FireAuth _fireAuth = FireAuth();
  final FireStorage _fireStorage = FireStorage();
  final TextEditingController _firstNameCntlr = TextEditingController();
  final TextEditingController _lastNameCntlr = TextEditingController();
  final TextEditingController _emailCntlr = TextEditingController();
  final TextEditingController _passwordCntlr = TextEditingController();
  String _gender = '';
  String _church = '';

  File? _selectedImage;
  DateTime? _dateOfBirth;
  bool _viewPassword = false;
  bool _viewPassword2 = false;
  bool _isLoading = false;

  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();
  final _firstNameKey = GlobalKey<FormState>();
  final _lastNameKey = GlobalKey<FormState>();

  TextEditingController get firstNameCntlr => _firstNameCntlr;
  TextEditingController get lastNameCntlr => _lastNameCntlr;
  String get gender => _gender;
  TextEditingController get emailCntlr => _emailCntlr;
  TextEditingController get passwordCntlr => _passwordCntlr;
  DateTime? get dateOfBirth => _dateOfBirth;
  File? get image => _selectedImage;
  String get selectedChurch => _church;

  GlobalKey<FormState> get firstNameKey => _firstNameKey;
  GlobalKey<FormState> get lastNameKey => _lastNameKey;
  GlobalKey<FormState> get emailKey => _emailKey;
  GlobalKey<FormState> get passwordKey => _passwordKey;

  bool get viewPassword => _viewPassword;
  bool get viewPassword2 => _viewPassword2;
  bool get isLoading => _isLoading;

  void setNameAndEmail({String? firstName, String? lastName, String? email}) {
    _firstNameCntlr.text = firstName ?? '';
    _lastNameCntlr.text = lastName ?? '';
    _emailCntlr.text = email ?? '';
    notifyListeners();
  }

  void setEmail({String? email}) {
    _emailCntlr.text = email ?? '';
    notifyListeners();
  }

  void setGender({String? gender}) {
    _gender = gender ?? '';
    notifyListeners();
  }

  void setPassword({String? password}) {
    _passwordCntlr.text = password ?? '';
    notifyListeners();
  }

  void setDateOfBirth({DateTime? date}) {
    _dateOfBirth = date;
    notifyListeners();
  }

  void setProfileImage({File? image}) {
    _selectedImage = image;

    notifyListeners();
  }

  void setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void setChurch({required String church}) {
    _church = church;
    notifyListeners();
  }

  void togglePasswordView() {
    _viewPassword = !_viewPassword;
    notifyListeners();
  }

  Future<void> signUp() async {
    final copUser = CopUser(
      isAdmin: false,
      firstName: _firstNameCntlr.text,
      lastName: _lastNameCntlr.text,
      birthDate: _dateOfBirth!,
      email: _emailCntlr.text.trim(),
      gender: _gender,
      church: _church,
    );

    final user = await _fireAuth.createUserEmailPassword(
      user: copUser,
      password: _passwordCntlr.text,
    );

    await _fireStorage.uploadProfileImage(image: _selectedImage, user: user!);
  }

  void close() {
    _emailCntlr.text = '';
    _firstNameCntlr.text = '';
    _lastNameCntlr.text = '';
    _passwordCntlr.text = '';
    _gender = '';
    _church = '';
    _dateOfBirth = null;
    _viewPassword = false;
    _viewPassword2 = false;
    _selectedImage = null;

    _firstNameKey.currentState?.reset();
    _lastNameKey.currentState?.reset();
    _emailKey.currentState?.reset();
    _passwordKey.currentState?.reset();
    _confirmPasswordKey.currentState?.reset();
  }
}
