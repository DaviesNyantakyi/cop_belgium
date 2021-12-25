class CopUser {
  String? id;
  String? photoUrl;

  String? firstName;
  String? lastName;
  String? title;
  bool isOnline;
  String? email;
  String? gender;
  String? church;
  bool? isFasting;
  bool isAdmin;
  String? address;
  String? phoneNumber;

  CopUser({
    this.photoUrl,
    this.id,
    required this.title,
    required this.isOnline,
    required this.isAdmin,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    required this.gender,
    required this.church,
    this.isFasting,
    this.address,
  });

  static CopUser fromMap({required Map<String, dynamic> map}) {
    return CopUser(
      id: map['id'],
      photoUrl: map['photoUrl'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      title: map['title'],
      isOnline: map['isOnline'],
      email: map['email'],
      gender: map['gender'],
      church: map['church'],
      isFasting: map['isFasting'],
      isAdmin: map['isAdmin'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
    );
  }

  static Map<String, dynamic> toMap({required CopUser copUser}) {
    return {
      'id': copUser.id,
      'photoUrl': copUser.photoUrl,
      'firstName': copUser.firstName,
      'lastName': copUser.lastName,
      'title': copUser.title,
      'isOnline': copUser.isOnline,
      'email': copUser.email,
      'gender': copUser.gender,
      'church': copUser.church,
      'isFasting': copUser.isFasting,
      'isAdmin': copUser.isAdmin,
      'address': copUser.address,
      'phoneNumber': copUser.phoneNumber
    };
  }
}
