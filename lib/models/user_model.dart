import 'package:cop_belgium/models/fasting_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';

class CopUser {
  String? photo;
  String? title;
  String firstName;
  String lastName;
  String email;
  String gender;
  String churchLocation;
  bool? isFasting;
  bool isAdmin;
  List<FastingInfo>? fastingHistory;
  List<PodCast>? favoratePodcast;
  Map<String, dynamic>? preferences;
  String? address;
  String? phoneNumber;

  CopUser({
    this.photo,
    this.title,
    required this.isAdmin,
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
