import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/services/fire_storage.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudFireStore _fireStore = CloudFireStore();

  Future<User?> signUpWithEmail(
      {required CopUser user, String? password}) async {
    try {
      if (user.firstName.isNotEmpty &&
          user.lastName.isNotEmpty &&
          user.gender.isNotEmpty &&
          user.email.isNotEmpty &&
          password != null) {
        String? displayName = '${user.firstName} ${user.lastName}';

        await _auth.createUserWithEmailAndPassword(
          email: user.email,
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
      final hasConnection = await ConnectionChecker().checkConnection();

      if (hasConnection) {
        if (email != null && email.isNotEmpty) {
          await _auth.sendPasswordResetEmail(email: email);
        }
      } else {
        throw ConnectionChecker.connectionException;
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

  Future<void> deleteUser({required String password}) async {
    final hasConnection = await ConnectionChecker().checkConnection();
    try {
      if (hasConnection) {
        await signIn(email: _auth.currentUser!.email, password: password);

        await CloudFireStore().deleteUserInfo();
        await _auth.currentUser!.delete();
        FireStorage().deleteUserStorageInfo();
      } else {
        throw ConnectionChecker.connectionException;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());

      rethrow;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
