import 'package:cop_belgium/models/episodes_model.dart';

class Podcast {
  final String id;
  final String pageLink;
  final String rssLink;
  final String image;
  final String title;
  final String description;
  final String speakers;
  final List<Episode>? episodes;
  final int totalEpisodes;

  Podcast({
    required this.id,
    required this.pageLink,
    required this.rssLink,
    required this.image,
    required this.title,
    required this.description,
    required this.speakers,
    required this.episodes,
    required this.totalEpisodes,
  });
}

class PodcastRssInfo {
  final String id;
  final String rssLink;
  final String? title;
  PodcastRssInfo({
    this.title,
    required this.id,
    required this.rssLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rssLink': rssLink,
      'title': title,
    };
  }

  factory PodcastRssInfo.fromMap({required Map<String, dynamic> map}) {
    return PodcastRssInfo(
      id: map['id'],
      rssLink: map['rssLink'],
      title: map['title'],
    );
  }
}
