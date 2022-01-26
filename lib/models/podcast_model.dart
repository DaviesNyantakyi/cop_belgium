import 'dart:convert';

import 'package:cop_belgium/models/episodes_model.dart';

class Podcast {
  final String imageUrl;
  final String title;
  final String description;
  final String author;
  final String pageLink;
  final List<Episode>? episodes;
  final int totalEpisodes;

  Podcast({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.pageLink,
    required this.episodes,
    required this.totalEpisodes,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'author': author,
      'pageLink': pageLink,
      'episodes': episodes,
      'totalEpisodes': totalEpisodes,
    };
  }

  factory Podcast.fromMap(Map<String, dynamic> map) {
    return Podcast(
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      author: map['author'] ?? '',
      pageLink: map['pageLink'] ?? '',
      episodes: map['episodes'] ?? [],
      totalEpisodes: map['totalEpisodes'] ?? 0,
    );
  }
}

class PodcastRssInfo {
  final String? id;
  final String rssLink;
  final String? title;
  PodcastRssInfo({
    this.title,
    this.id,
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
