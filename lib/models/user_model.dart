import 'package:cop_belgium/models/fasting_model.dart';

class CopUser {
  String? photo;
  String firstName;
  String lastName;
  String email;
  String gender;
  String churchLocation;
  String? title;
  bool? isFasting;
  List<FastingInfo>? fastingHistory;
  Map<String, dynamic>? preferences;
  String? address;
  String? phoneNumber;

  CopUser({
    this.photo,
    this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    required this.gender,
    required this.churchLocation,
    this.isFasting,
    this.fastingHistory,
    this.preferences,
    this.address,
  });
}
