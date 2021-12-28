import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/models/user_model.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class CloudFireStore {
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;
  final _connectionChecker = ConnectionChecker();

  Future<void> createTestimony({required TestimonyInfo testimony}) async {
    try {
      bool hasConnection = await _connectionChecker.checkConnection();

      if (hasConnection) {
        if (testimony.userId.isNotEmpty &&
            testimony.title != null &&
            testimony.description != null &&
            testimony.date != null) {
          final docRef = await _firestore
              .collection('Testimonies')
              .add(TestimonyInfo.toMap(map: testimony));
          docRef.update({'id': docRef.id});
        }
      } else {
        throw ConnectionChecker.connectionException;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> updateTestimonyInfo({required TestimonyInfo tInfo}) async {
    try {
      bool hasConnection = await _connectionChecker.checkConnection();

      // voor dat we de tesitmony aanmaken checken we als we interne connectie hebben.
      // als we internet connectie hebben update de testimony doc
      // else throw error no internet connection

      if (hasConnection) {
        await _firestore.collection('Testimonies').doc(tInfo.id).update(
              TestimonyInfo.toMap(map: tInfo),
            );
      } else {
        throw ConnectionChecker.connectionException;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteTestimony({required TestimonyInfo? testimony}) async {
    try {
      bool hasConnection = await _connectionChecker.checkConnection();

      if (hasConnection) {
        // delete likers collection first otherwise the doc will still remain
        final collection = _firestore
            .collection('Testimonies')
            .doc(testimony!.id)
            .collection('likers');
        final snapshots = await collection.get();
        for (var doc in snapshots.docs) {
          await doc.reference.delete();
        }

        // delete doc
        await _firestore.collection('Testimonies').doc(testimony.id).delete();
      } else {
        throw ConnectionChecker.connectionException;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> likeDislikeTestimony({required TestimonyInfo tInfo}) async {
    try {
      bool hasConnection = await _connectionChecker.checkConnection();
      if (hasConnection) {
        // Create a uniek document id  basen on the testimonyInfo id and the userId.
        // (this can also be done with the .where() where filter and get only the doc with the tInfo.id and userId)
        String docRef = tInfo.id.toString() + _user!.uid;

        // Try to get the document in the likes collection.
        final docSnap = await getTestimonyLikeDoc(tInfo: tInfo, docRef: docRef);

        // the user has clicked on the like button:
        // If the doc does not exits in the Testimony likers collection.
        // Then it means that the user has not liked the testimony.
        if (docSnap.exists == false) {
          // Like

          //  document is created with a uniek id in the likes collection.
          await createTestimonyLikeDoc(tInfo: tInfo, docRef: docRef);
        } else {
          // Dislike
          // If doc exist then it means the user has disliked.
          // So we delete the document in the likers collection.
          deleteTestimonyLikeDoc(tInfo: tInfo, docRef: docRef);
        }
      } else {
        throw ConnectionChecker.connectionException;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getTestimonyLikeDoc({
    required TestimonyInfo tInfo,
    required String docRef,
  }) async {
    // This gets the document with the uniek ref in the likes collection.
    return await FirebaseFirestore.instance
        .collection('Testimonies')
        .doc(tInfo.id)
        .collection('likers')
        .doc(docRef)
        .get();
  }

  Future<void> createTestimonyLikeDoc({
    required TestimonyInfo tInfo,
    required String docRef,
  }) async {
    final currenDate = DateTime.now();
    try {
      // This method allows us to soo ho liked the post.
      // Upload a document with a unqiek id to the specific testimony doc likers collection.
      await _firestore
          .collection('Testimonies')
          .doc(tInfo.id)
          .collection('likers')
          .doc(docRef)
          .set(({
            'id': docRef,
            'testimonyId': tInfo.id,
            'userId': _user!.uid,
            'date': currenDate
          }));

      // update testimony info like count
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<PodcastRssInfo?>> getPodcastRssInfoFireStore() async {
    // get the podcast rss link and page link from firestore.
    try {
      final qSnap =
          await FirebaseFirestore.instance.collection('podcasts').get();
      final listQDocSnap = qSnap.docs;

      List<PodcastRssInfo> listPodRssInfo = listQDocSnap.map((doc) {
        return PodcastRssInfo.fromMap(map: doc.data());
      }).toList();

      return listPodRssInfo;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteTestimonyLikeDoc(
      {required TestimonyInfo tInfo, required String docRef}) async {
    try {
      // delete the doc with the liker info in the likers collection.
      await FirebaseFirestore.instance
          .collection('Testimonies')
          .doc(tInfo.id)
          .collection('likers')
          .doc(docRef)
          .delete();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> createFastHistory({required FastingInfo fInfo}) async {
    try {
      if (fInfo.userId != null &&
          fInfo.startDate != null &&
          fInfo.endDate != null &&
          fInfo.goalDate != null) {
        final docRef = await _firestore
            .collection('Users')
            .doc(_user!.uid)
            .collection('Fasting history')
            .add(FastingInfo.toMap(map: fInfo));
        await docRef.update({'id': docRef.id});
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> deleteFastHistory({required FastingInfo fInfo}) async {
    try {
      await _firestore
          .collection('Users')
          .doc(_user!.uid)
          .collection('Fasting history')
          .doc(fInfo.id)
          .delete();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> createUserDoc({required CopUser user}) async {
    try {
      if (user.id != null &&
          user.lastName != null &&
          user.firstName != null &&
          user.email != null) {
        await _firestore.collection('Users').doc(user.id).set(
              CopUser.toMap(copUser: user),
            );
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
