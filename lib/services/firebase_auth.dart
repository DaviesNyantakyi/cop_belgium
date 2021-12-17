import 'package:cop_belgium/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

class FirbaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmail({
    required CopUser copUser,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: copUser.email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
