import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudFireStore _fireStore = CloudFireStore();

  Future<User?> signUpWithEmail(
      {required CopUser user, String? password}) async {
    try {
      if (user.firstName != null &&
          user.lastName != null &&
          user.email != null &&
          password != null &&
          user.gender != null) {
        String? displayName = '${user.firstName} ${user.lastName}';

        await _auth.createUserWithEmailAndPassword(
          email: user.email!,
          password: password,
        );
        await _auth.currentUser!.updateDisplayName(displayName);
        user.id = _auth.currentUser!.uid;
        await _fireStore.createUserDoc(user: user);
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
