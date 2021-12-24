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

  Future<void> updateTestimony({required TestimonyInfo tInfo}) async {
    try {
      await _firestore.collection('Testimonies').doc(tInfo.id).update(
            TestimonyInfo.toMap(map: tInfo),
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

  Future<void> likeDislikeTestimony({required TestimonyInfo tInfo}) async {
    try {
      //Create a uniek document id  basen on the testimonyInfo id and the userId.
      // (this can also be done with the .where() where filter and get only the doc with the tInfo.id and userId)
      String docRef = tInfo.id.toString() + _user!.uid;

      // Try to get the document in the likes collection.
      final docSnap = await getTestimonyLikeDoc(tInfo: tInfo, docRef: docRef);

      // the user has clicked on the like button:
      // If the doc does not exits in the Testimony likes collection.
      // Then it means that the user has not liked the testimony.
      // So a document is created with a uniek id in the likes collection.
      if (docSnap.exists == false) {
        // Liked.
        createTestimonyLikeDoc(tInfo: tInfo, docRef: docRef);
      } else {
        // Disliked.
        // If doc exist then it means the user has disliked.
        // So we delete the document in the likes collection.
        deleteTestimonyLikeDoc(tInfo: tInfo, docRef: docRef);
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteTestimonyLikeDoc(
      {required TestimonyInfo tInfo, required String docRef}) async {
    return await FirebaseFirestore.instance
        .collection('Testimonies')
        .doc(tInfo.id)
        .collection('likes')
        .doc(docRef)
        .delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getTestimonyLikeDoc({
    required TestimonyInfo tInfo,
    required String docRef,
  }) async {
    // This gets the document with the uniek ref in the likes collection.
    return await FirebaseFirestore.instance
        .collection('Testimonies')
        .doc(tInfo.id)
        .collection('likes')
        .doc(docRef)
        .get();
  }

  Future<void> createTestimonyLikeDoc({
    required TestimonyInfo tInfo,
    required String docRef,
  }) async {
    final currenDate = DateTime.now();
    try {
      // Upload a document with a unqiek id to the specific testimony likes collection.
      await _firestore
          .collection('Testimonies')
          .doc(tInfo.id)
          .collection('likes')
          .doc(docRef)
          .set(({
            'id': docRef,
            'testimonyId': tInfo.id,
            'userId': _user!.uid,
            'date': currenDate
          }));
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> createFast({required FastingInfo fInfo}) async {
    try {
      if (fInfo.userId != null &&
          fInfo.startDate != null &&
          fInfo.endDate != null &&
          fInfo.goalDate != null) {
        final docRef = await _firestore
            .collection('Fasting Histories')
            .add(FastingInfo.toMap(map: fInfo));

        await docRef.update({'id': docRef.id});
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
