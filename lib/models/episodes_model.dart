class Episode {
  final String? image;
  final String title;
  final String description;
  final String audio;
  final int duration;
  final DateTime date;
  Episode({
    required this.image,
    required this.title,
    required this.description,
    required this.audio,
    required this.duration,
    required this.date,
  });

  Map<String, dynamic> toMap({required Episode episode}) {
    return {
      'audio': episode.audio,
      'image': episode.image,
      'title': episode.title,
      'description': episode.description,
      'duration': episode.duration,
      'date': episode.date.millisecondsSinceEpoch,
    };
  }

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      audio: map['audio'],
      image: map['image'],
      title: map['title'],
      description: map['description'],
      duration: map['duration'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }
}
