import 'package:flutter/cupertino.dart';

class Testimony {
  final String userId;
  String title;
  String testimony;
  double likes;
  final DateTime date;
  Color? cardColor;

  Testimony({
    required this.userId,
    required this.title,
    required this.testimony,
    required this.likes,
    required this.date,
    this.cardColor,
  });
}
