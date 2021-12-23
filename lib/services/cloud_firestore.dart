import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/main.dart';
import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class CloudFireStore {
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  // upload testimony  to firestore

  // create function with input testimony object.
  // upload to tesimonies collection

  Future<void> createTestimony({required TestimonyInfo testimony}) async {
    try {
      if (testimony.userId.isNotEmpty &&
          testimony.title != null &&
          testimony.description != null &&
          testimony.date != null) {
        final docRef = await _firestore
            .collection('Testimonies')
            .add(TestimonyInfo.toMap(map: testimony));
        docRef.update({'id': docRef.id});
      }
    } catch (e) {
      debugPrint(e.toString() + ' davies');
      rethrow;
    }
  }

  Future<void> updateTestimony({required TestimonyInfo testimony}) async {
    try {
      await _firestore.collection('Testimonies').doc(testimony.id).update(
            TestimonyInfo.toMap(map: testimony),
          );
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteTestimony({required TestimonyInfo? testimony}) async {
    try {
      await _firestore.collection('Testimonies').doc(testimony!.id).delete();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> likeTestimony({required TestimonyInfo testimonyInfo}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      String docRef = testimonyInfo.id.toString() + currentUser!.uid;

      final docSnap = await FirebaseFirestore.instance
          .collection('Testimonies')
          .doc(testimonyInfo.id)
          .collection('likes')
          .doc(docRef)
          .get();

      if (docSnap.exists == false) {
        createTestimonyLikeDoc(testimonyInfo: testimonyInfo);
      } else {
        await FirebaseFirestore.instance
            .collection('Testimonies')
            .doc(testimonyInfo.id)
            .collection('likes')
            .doc(docRef)
            .delete();
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> createTestimonyLikeDoc(
      {required TestimonyInfo testimonyInfo}) async {
    final currenDate = DateTime.now();

    // create a documet ref with the testimonyInfo + userId
    String docRef = testimonyInfo.id.toString() + _user!.uid;
    try {
      // upload to fireStore
      await _firestore
          .collection('Testimonies')
          .doc(testimonyInfo.id)
          .collection('likes')
          .doc(docRef)
          .set(({
            'id': docRef,
            'testimonyId': testimonyInfo.id,
            'userId': _user!.uid,
            'date': currenDate
          }));
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> createFast({required FastingInfo fastingInfo}) async {
    try {
      if (fastingInfo.userId != null &&
          fastingInfo.startDate != null &&
          fastingInfo.endDate != null &&
          fastingInfo.goalDate != null) {
        final docRef = await _firestore
            .collection('Fasting Histories')
            .add(FastingInfo.toMap(map: fastingInfo));

        await docRef.update({'id': docRef.id});
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
