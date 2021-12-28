import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/utilities/rss_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';

class PodcastRssHandler {
  Future<Podcast> getPodcastRss({required String rssLink}) async {
    try {
      Uri url = Uri.parse(rssLink);
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        RssFeed rssFeed = RssFeed.parse(response.body);

        final allEpisodes = rssFeed.items!.map((rssItem) {
          return Episode(
            id: rssItem.link!,
            title: rssItem.itunes!.title!,
            image: rssItem.itunes?.image?.href ?? rssFeed.itunes!.image!.href,
            duration: rssItem.itunes!.duration!.inMilliseconds,
            date: rssItem.pubDate!,
            audio: rssItem.enclosure!.url!,
            description:
                RssHelper.getDescription(item: rssItem), // remove p tag
          );
        }).toList();
        final podcast = Podcast(
          id: RssHelper.getRssPath(rssFeed: rssFeed),
          pageLink: rssFeed.link!,
          rssLink: RssHelper.getRssLink(rssFeed: rssFeed),
          image: rssFeed.itunes!.image!.href!,
          title: rssFeed.title!,
          description: rssFeed.itunes!.summary!,
          speakers: rssFeed.itunes!.author!,
          episodes: allEpisodes,
          totalEpisodes: rssFeed.items!.length,
        );

        return podcast;
      } else {
        throw FirebaseException(
          code: 'Status code Error',
          plugin: 'http',
          message: 'Something whent wrong whiles making the request',
          //TODO: change  and test the error message.
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<PodcastRssInfo>> getPodcastInfoFireStore() async {
    final qSnap = await FirebaseFirestore.instance.collection('podcasts').get();
    final listQDocSnap = qSnap.docs;
    List<PodcastRssInfo> listPodRssInfo = listQDocSnap.map((doc) {
      return PodcastRssInfo.fromMap(map: doc.data());
    }).toList();

    return listPodRssInfo;
  }

  Future<List<Podcast>> getPodcast() async {
    final List<Podcast> podcasts = [];
    final firebaseInfo = await getPodcastInfoFireStore();

    for (var info in firebaseInfo) {
      Podcast podcast = await getPodcastRss(rssLink: info.rssLink);
      podcasts.add(podcast);
    }
    return podcasts;
  }
}





// info in app
// image: rssFeed.itunes!.image!.href
// title: rssFeed.title
// descritpion: rssFeed.itunes!.summary
// length of the episodes: rssFeed.items!.length
// author: rssFeed.itunes!.author
// link: rssFeed.link

//Info in firestore
//id (generator);
//link rss

//Scnerio getting podcast from firebase
// 1: maak een collection podcastLinks
// 2: maak een spashot een pak elk document in the collection
// 3: voor elk doc in de collection maak ik een request om de pocast op te halen. 



// Scnerio uploading podcast
// 1: Pocast is geupload naar redCircle
// 2: Doc aanmaken met als id redCircle path (na the /)
// 3: the field id en link rss toevoegen
// 4: id is the volledige generator link

