import 'dart:io';

import 'package:cop_belgium/services/cloud_fire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

const userProfilePath = 'images/profile_images';

class FireStorage {
  final _user = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseStorage.instance;
  final _cloudFire = CloudFire();

  // User

  Future<void> updateProfileImage({
    required File? image,
    required bool delete,
  }) async {
    try {
      // Delete profile image if the user has not seletecd a image and delete is true.
      if (image == null && delete) {
        await deleteProfileImage();
        await _cloudFire.updatePhotoURL(url: null);
        await _user?.updatePhotoURL(null);
        return;
      }

      if (image != null && _user?.uid != null) {
        final ref = await _fireStore
            .ref()
            .child('users/${_user?.uid}/images/${_user?.uid}')
            .putFile(image);
        final url = await getPhotoUrl(fileRef: ref.ref.fullPath);
        await _user?.updatePhotoURL(url);
        await _cloudFire.updatePhotoURL(url: url);
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteProfileImage() async {
    try {
      final userId = _user?.uid;
      if (userId != null) {
        await _fireStore.ref('users/$userId/images/$userId').delete();
      }
    } on FirebaseStorage catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<String> getPhotoUrl({required String fileRef}) async {
    try {
      return await _fireStore.ref(fileRef).getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser() async {
    try {
      if (_user?.uid != null) {
        await _fireStore.ref('users/${_user!.uid}').delete();
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<String?> uploadFile({
    required String? id,
    required String storagePath,
    File? file,
  }) async {
    try {
      if (file != null) {
        final ref = await _fireStore.ref('$storagePath/$id').putFile(file);
        return await getPhotoUrl(fileRef: ref.ref.fullPath);
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    return null;
  }
}
