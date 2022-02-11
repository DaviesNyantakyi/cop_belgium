import 'package:cloud_firestore/cloud_firestore.dart';

class CopUser {
  String? id;
  String? photoUrl;
  String firstName;
  String lastName;
  String email;
  String gender;
  DateTime birthDate;
  bool isAdmin;

  CopUser({
    this.id,
    this.photoUrl,
    required this.isAdmin,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.email,
    required this.gender,
  });

  static CopUser fromMap({required Map<String, dynamic> map}) {
    final birthDate = (map['birthDate'] as Timestamp).millisecondsSinceEpoch;
    return CopUser(
      id: map['id'],
      photoUrl: map['photoUrl'],
      birthDate: DateTime.fromMillisecondsSinceEpoch(birthDate),
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      gender: map['gender'],
      isAdmin: map['isAdmin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'firstName': firstName,
      'lastName': lastName,
      'isAdmin': isAdmin,
      'birthDate': birthDate,
      'email': email,
      'gender': gender,
    };
  }
}
