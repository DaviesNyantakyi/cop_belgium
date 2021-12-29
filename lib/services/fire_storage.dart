import 'dart:io';

import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStorage {
  final _user = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseStorage.instance;

  Future<void> uploadProfileImage({File? image}) async {
    try {
      if (image != null) {
        final userId = _user!.uid;
        final ref =
            await _fireStore.ref('profile_photos/$userId').putFile(image);
        final url = await getPhotoUrl(fileRef: ref.ref.fullPath);
        await _user?.updatePhotoURL(url);

        await CloudFireStore().updatePhotoUrl(photoUrl: url);
      }
    } on FirebaseStorage catch (e) {
      debugPrint(e.toString() + 'print()');
      rethrow;
    }
  }

  Future<String> getPhotoUrl({required String fileRef}) async {
    return await _fireStore.ref(fileRef).getDownloadURL();
  }
}
