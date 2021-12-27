// import 'package:webfeed/domain/rss_feed.dart';

// class RssFinder {
//   static String getRssPath({required RssFeed rssFeed}) {
//     //this returns the podcast path id from redcircle

//     String podcastPath = rssFeed.generator!.split('_')[2];
//     return podcastPath;
//   }

//   static String getRssLink({required RssFeed rssFeed}) {
//     //This method returns a rss link using the redcircle url and the path we get back from the rss generator.

//     String redCircleUrl = 'https://feeds.redcircle.com/';

//     //cc66bbb2-1317-4712-b52e-28c52854a8a0
//     String podcastPath = getRssPath(rssFeed: rssFeed);

//     // new link: https://feeds.redcircle.com/cc66bbb2-1317-4712-b52e-28c52854a8a0
//     String rssLink = redCircleUrl + podcastPath;

//     return rssLink;
//   }
// }
