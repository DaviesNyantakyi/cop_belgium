class EpisodeModel {
  final String image;
  final String title;
  final String description;
  final String audioUrl;
  final String author;
  final String podcastName;
  final Duration duration;
  final DateTime date;
  final String podcastUrl;
  EpisodeModel({
    required this.image,
    required this.title,
    required this.author,
    required this.description,
    required this.audioUrl,
    required this.duration,
    required this.podcastUrl,
    required this.podcastName,
    required this.date,
  });

  Map<String, dynamic> toMap({required EpisodeModel episode}) {
    return {
      'audioUrl': episode.audioUrl,
      'image': episode.image,
      'title': episode.title,
      'author': episode.author,
      'podcastUrl': episode.podcastUrl,
      'podcastName': episode.podcastName,
      'description': episode.description,
      'duration': episode.duration,
      'date': episode.date.millisecondsSinceEpoch,
    };
  }

  factory EpisodeModel.fromMap(Map<String, dynamic> map) {
    return EpisodeModel(
      audioUrl: map['audioUrl'],
      image: map['image'],
      author: map['author'],
      title: map['title'],
      podcastUrl: map['podcastUrl'],
      podcastName: map['podcastName'],
      description: map['description'],
      duration: map['duration'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }
}
