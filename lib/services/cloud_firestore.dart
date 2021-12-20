import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CloudFireStore {
  final _firestore = FirebaseFirestore.instance;

  // upload testimony  to firestore

  // create function with input testimony object.
  // upload to tesimonies collection

  Future<void> createTestimony({required TestimonyInfo testimony}) async {
    try {
      if (testimony.userId.isNotEmpty &&
          testimony.title != null &&
          testimony.testimony != null &&
          testimony.date != null) {
        final docRef = await _firestore.collection('testimonies').add(
              TestimonyInfo.toMap(map: testimony),
            );
        await docRef.update({'id': docRef.id});
      }
    } catch (e) {
      debugPrint(e.toString() + ' davies');
      rethrow;
    }
  }

  Future<void> updateTestimony({required TestimonyInfo testimony}) async {
    try {
      _firestore.collection('testimonies').doc(testimony.id).update({
        'title': testimony.title,
        'testimony': testimony.testimony,
        'cardColor': testimony.cardColor,
      });
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteTestimony({required TestimonyInfo? testimony}) async {
    try {
      await _firestore.collection('testimonies').doc(testimony!.id).delete();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
