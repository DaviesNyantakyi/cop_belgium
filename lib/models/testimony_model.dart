import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Testimony {
  final String? userId;
  String? title;
  String? testimony;
  double? likes;
  final DateTime? date;
  String? cardColor;

  Testimony({
    required this.userId,
    required this.title,
    required this.testimony,
    this.likes,
    required this.date,
    this.cardColor,
  });

  static Map<String, dynamic> toMap({required Testimony testimony}) {
    return {
      'userId': testimony.userId,
      'title': testimony.title,
      'testimony': testimony.testimony,
      'likes': testimony.likes,
      'date': testimony.date,
      'cardColor': testimony.cardColor,
    };
  }
}
