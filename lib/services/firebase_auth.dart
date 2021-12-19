import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmail({
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? password,
    required String? selectedChurch,
    required String? gender,
  }) async {
    try {
      if (firstName != null &&
          firstName.isNotEmpty &&
          lastName != null &&
          lastName.isNotEmpty &&
          email != null &&
          email.isNotEmpty &&
          password != null &&
          password.isNotEmpty &&
          selectedChurch != null &&
          selectedChurch.isNotEmpty &&
          gender != null &&
          gender.isNotEmpty) {
        String? displayName = '$firstName ' + lastName;
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _auth.currentUser!.updateDisplayName(displayName);

        return _auth.currentUser;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> singout() async {
    await _auth.signOut();
  }

  Future<void> sendResetPassword({required String? email}) async {
    try {
      if (email != null && email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<User?> signIn(
      {required String? email, required String? password}) async {
    try {
      if (email != null && password != null) {
        final user = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return user.user;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
