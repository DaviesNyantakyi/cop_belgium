// Login for adding search index
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/church_model.dart';

Future<void> addSearchIndex({required Church church}) async {
  final churchName = church.churchName.split('');

  List<String> searchIndex = [];

  String newWord = '';
  for (var i = 0; i < churchName.length; i++) {
    newWord = newWord + churchName[i];

    searchIndex.add(newWord.toLowerCase());
  }

  await FirebaseFirestore.instance
      .collection('churches')
      .doc(church.id)
      .update({'searchIndex': searchIndex});
}
