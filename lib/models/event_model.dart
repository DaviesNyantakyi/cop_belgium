class Event {
  DateTime startDate;
  DateTime endDate;
  String title;
  String description;
  String type;
  String image;
  String? link;
  Map<String, dynamic>? location;

  Event({
    required this.startDate,
    required this.endDate,
    required this.title,
    required this.description,
    required this.type,
    required this.image,
    this.link,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'title': title,
      'description': description,
      'type': type,
      'image': image,
      'zoomLink': link,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? '',
      image: map['image'] ?? '',
      link: map['zoomLink'] ?? '',
    );
  }
}
