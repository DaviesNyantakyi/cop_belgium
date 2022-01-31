import 'package:cop_belgium/models/episodes_model.dart';

class Podcast {
  final String imageUrl;
  final String title;
  final String description;
  final String author;
  final String pageLink;
  final List<Episode>? episodes;

  Podcast({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.pageLink,
    required this.episodes,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'author': author,
      'pageLink': pageLink,
      'episodes': episodes,
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
//  Podcast createPodcast({required RssFeed rssFeed}) {
//     // creates a podcast using the rss info and also adds all the episodes

//     List<Episode> episodes = rssFeed.items!.map((rssItem) {
//       return Episode(
//         title: rssItem.itunes?.title ?? rssItem.title ?? '',
//         author:
//             rssItem.itunes?.author ?? rssItem.author ?? rssFeed.author ?? '',
//         image: rssFeed.itunes?.image?.href ?? rssFeed.image?.url ?? '',
//         duration: rssItem.itunes?.duration?.inMilliseconds ?? 0,
//         date: rssItem.pubDate ?? DateTime.now(),
//         audio: rssItem.enclosure?.url ?? '',
//         description: RssHelper.getDescription(item: rssItem), // remove p tag
//       );
//     }).toList();

//     return Podcast(
//       pageLink: rssFeed.link ?? '',
//       imageUrl: rssFeed.image?.url ?? rssFeed.itunes?.image?.href ?? ' ',
//       title: rssFeed.itunes?.title ?? rssFeed.title ?? ' ',
//       description: rssFeed.description ?? rssFeed.itunes?.summary ?? '',
//       author: rssFeed.itunes?.author ?? rssFeed.author ?? '',
//       episodes: episodes,
//       totalEpisodes: rssFeed.items?.length ?? 0,
//     );
//   }