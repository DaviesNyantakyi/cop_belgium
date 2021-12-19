import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:flutter/cupertino.dart';

class CloudFireStore {
  final _firestore = FirebaseFirestore.instance;

  // upload testimony  to firestore

  // create function with input testimony object.
  // upload to tesimonies collection

  Future<void> createTestimony({required Testimony testimony}) async {
    try {
      if (testimony.userId != null &&
          testimony.title != null &&
          testimony.testimony != null &&
          testimony.date != null) {
        await _firestore.collection('testimonies').add(
              Testimony.toMap(testimony: testimony),
            );
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString() + ' davies');
      rethrow;
    }
  }
}
