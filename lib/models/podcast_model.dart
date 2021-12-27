import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/models/user_model.dart';

class PodCast {
  final String id;
  final String pageLink;
  final String rssLink;
  final String image;
  final String title;
  final String description;
  final DateTime dateTime;
  final List<CopUser> speakers;
  final List<Episode> episodes;
  final int totalEpisodes;
  final Duration duration;

  PodCast({
    required this.id,
    required this.pageLink,
    required this.rssLink,
    required this.image,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.speakers,
    required this.episodes,
    required this.totalEpisodes,
    required this.duration,
  });
}
