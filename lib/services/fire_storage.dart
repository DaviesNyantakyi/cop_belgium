import 'dart:io';

import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStorage {
  final _user = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseStorage.instance;

  Future<void> uploadProfileImage(
      {required File? image, required User? user}) async {
    try {
      if (image != null && user != null) {
        final ref = await _fireStore
            .ref('images/profile_images/${user.uid}')
            .putFile(image);
        final url = await getPhotoUrl(fileRef: ref.ref.fullPath);
        await _user?.updatePhotoURL(url);
        await CloudFireStore().updatePhotoUrl(photoUrl: url);
      }
    } on FirebaseStorage catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<String> getPhotoUrl({required String fileRef}) async {
    return await _fireStore.ref(fileRef).getDownloadURL();
  }

  Future<void> deleteUserStorageInfo() async {
    try {
      final userId = _user?.uid;
      if (userId != null) {
        await _fireStore.ref('images/profile_images/$userId').delete();
      }
    } on FirebaseStorage catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
