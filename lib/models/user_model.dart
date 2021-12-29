class CopUser {
  String? id;
  String? photoUrl;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  bool isOnline;
  bool isAdmin;

  CopUser({
    this.id,
    this.photoUrl,
    required this.isOnline,
    required this.isAdmin,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
  });

  static CopUser fromMap({required Map<String, dynamic> map}) {
    return CopUser(
      id: map['id'],
      photoUrl: map['photoUrl'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      gender: map['gender'],
      isOnline: map['isOnline'],
      isAdmin: map['isAdmin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'firstName': firstName,
      'lastName': lastName,
      'isOnline': isOnline,
      'isAdmin': isAdmin,
      'email': email,
      'gender': gender,
    };
  }
}
