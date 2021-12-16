class CopUser {
  String? profileImage;
  String firstName;
  String lastName;
  String email;
  String gender;
  String? churchLocation;
  bool isFasting;

  CopUser({
    required this.profileImage,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.churchLocation,
    required this.isFasting,
  });
}
