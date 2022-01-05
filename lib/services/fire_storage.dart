import 'dart:io';

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
      bool hasConnection = await ConnectionChecker().checkConnection();
      if (hasConnection) {
        if (image != null) {
          final userId = _user!.uid;
          final ref = await _fireStore
              .ref('images/profile_images/$userId')
              .putFile(image);
          final url = await getPhotoUrl(fileRef: ref.ref.fullPath);
          await _user?.updatePhotoURL(url);

          await CloudFireStore().updatePhotoUrl(photoUrl: url);
        }
      } else {
        throw ConnectionChecker.connectionException;
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
      final userId = _user!.uid;
      await _fireStore.ref('images/profile_images/$userId').delete();
    } on FirebaseStorage catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
