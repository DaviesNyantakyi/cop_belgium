//TODO: think about type of announcements.
// You can have global and a announcement specific to a church (subscription type).

class Announcement {
  final String title;
  final String description;
  final DateTime dateTime;
  Announcement({
    required this.title,
    required this.description,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }
}
