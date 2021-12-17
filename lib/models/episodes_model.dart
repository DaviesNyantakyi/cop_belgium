import 'package:cop_belgium/models/user_model.dart';

class Episode {
  final String title;
  final String description;
  final String image;
  final String audio;
  final int lenght;
  final DateTime date;
  final int likes;
  final List<CopUser> speakers;

  Episode({
    required this.title,
    required this.description,
    required this.image,
    required this.audio,
    required this.lenght,
    required this.date,
    required this.likes,
    required this.speakers,
  });
}
