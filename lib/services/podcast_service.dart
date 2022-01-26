import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/services/cloud_firestore.dart';
import 'package:cop_belgium/utilities/connection_checker.dart';
import 'package:cop_belgium/utilities/rss_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';

class PodcastService {
  final CloudFireStore _fireStore = CloudFireStore();

  Future<RssFeed> getRssFeed({required String rssLink}) async {
    // get the rss body and turns it into an podcast

    final hasConnection = await ConnectionChecker().checkConnection();
    if (hasConnection) {
      try {
        Uri url = Uri.parse(rssLink);
        http.Response response = await http.get(url);

        if (response.statusCode == 200) {
          return RssFeed.parse(response.body);
        } else {
          throw FirebaseException(
            code: 'Status code Error',
            plugin: 'http',
            message: 'Something went wrong while making the request.',
          );
        }
      } catch (e) {
        debugPrint(e.toString());
        rethrow;
      }
    } else {
      throw ConnectionChecker.connectionException;
    }
  }

  Podcast createPodcast({required RssFeed rssFeed}) {
    // creates a podcast using the rss info and also adds all the episodes

    List<Episode> episodes = rssFeed.items!.map((rssItem) {
      return Episode(
        title: rssItem.itunes!.title!,
        image: rssItem.itunes?.image?.href ?? rssFeed.itunes!.image!.href,
        duration: rssItem.itunes!.duration!.inMilliseconds,
        date: rssItem.pubDate!,
        audio: rssItem.enclosure!.url!,
        description: RssHelper.getDescription(item: rssItem), // remove p tag
      );
    }).toList();

    return Podcast(
      pageLink: rssFeed.link!,
      imageUrl: rssFeed.itunes!.image!.href!,
      title: rssFeed.title!,
      description: rssFeed.itunes!.summary!,
      author: rssFeed.itunes!.author!,
      episodes: episodes,
      totalEpisodes: rssFeed.items!.length,
    );
  }

  Future<List<Podcast>> getPodcast() async {
    try {
      final List<Podcast> podcasts = [];
      final firebaseInfo = await _fireStore.getPodcastRssInfoFireStore();

      for (var info in firebaseInfo) {
        RssFeed rssFeed = await getRssFeed(rssLink: info!.rssLink);

        Podcast podcast = createPodcast(rssFeed: rssFeed);
        podcasts.add(podcast);
      }
      return podcasts;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Podcast>> getSavedPodcast() async {
    try {
      final List<Podcast> podcasts = [];
      final firebaseInfo = await _fireStore.getUserSavedPodcast();

      for (var info in firebaseInfo) {
        RssFeed rssFeed = await getRssFeed(rssLink: info!.rssLink);
        Podcast podcast = createPodcast(rssFeed: rssFeed);
        podcasts.add(podcast);
      }
      return podcasts;
    } catch (e) {
      rethrow;
    }
  }
}
