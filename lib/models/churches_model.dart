import 'package:cop_belgium/models/user_model.dart';

class Church {
  final String name;
  final String postcode;
  final String street;
  final String city;
  final String telephoneNumber;
  final String email;
  final List<String> languages;
  final List<CopUser> members;
  final List<CopUser> leaders;

  Church({
    required this.leaders,
    required this.name,
    required this.postcode,
    required this.street,
    required this.city,
    required this.telephoneNumber,
    required this.email,
    required this.languages,
    required this.members,
  });
}
