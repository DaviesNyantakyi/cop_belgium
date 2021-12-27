import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';

class PodcastRssHandler {
  Future<RssFeed> getPodcastRss() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      Uri url = Uri.parse(
          'https://feeds.redcircle.com/cc66bbb2-1317-4712-b52e-28c52854a8a0');

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        RssFeed rssFeed = RssFeed.parse(response.body);
        return rssFeed;
      } else {
        throw FirebaseException(
          code: 'Status code Error',
          plugin: 'http',
          message: 'Something whent wrong whiles making the request',
          //TODO: change  and test error message;
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
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



//Scnerio getting podcast 
// 1: maak een collection podcastLinks
// 2: maak een spashot een pak elk document in the collection
// 3: de doc bevat de link naar de podcast


// Scnerio uploading podcast
// 1: Pocast is geupload naar redCircle
// 2: Doc aanmaken met als id redCircle path (na the /)
// 3: the field id en link rss toevoegen
// 4: id is the volledige generator link