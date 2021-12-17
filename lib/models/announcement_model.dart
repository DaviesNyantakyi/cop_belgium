import 'package:cop_belgium/models/user_model.dart';

class Announcement {
  final String title;
  final DateTime date;
  final String description;
  final CopUser author;

  Announcement({
    required this.title,
    required this.date,
    required this.description,
    required this.author,
  });
}
