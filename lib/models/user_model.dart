import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';

class CopUser {
  String? photoUrl;
  String firstName;
  String lastName;
  String title;
  bool isOnline;
  String email;
  String gender;
  String church;
  bool? isFasting;
  bool isAdmin;
  String? address;
  String? phoneNumber;

  CopUser({
    this.photoUrl,
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
}
