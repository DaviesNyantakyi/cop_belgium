import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:html/parser.dart' show parse;

//TODO: delete make rssLink and getTokenPath so that the podcast server can get any rssLink
class RssHelper {
  static String getTokenRssPath({required RssFeed rssFeed}) {
    //this returns the podcast path id from redcircle

    // RedCircle VERIFY_TOKEN_cc66bbb2-1317-4712-b52e-28c52854a8a0
    String podcastPath = rssFeed.generator!.split('_')[2];
    // cc66bbb2-1317-4712-b52e-28c52854a8a0
    return podcastPath;
  }

  static String makeRssLink({required RssFeed rssFeed}) {
    //This method returns a rss link using the redcircle url and the path we get back from the rss generator.

    String redCircleUrl = 'https://feeds.redcircle.com/';

    //cc66bbb2-1317-4712-b52e-28c52854a8a0
    String podcastPath = getTokenRssPath(rssFeed: rssFeed);

    // new link: https://feeds.redcircle.com/cc66bbb2-1317-4712-b52e-28c52854a8a0
    String rssLink = redCircleUrl + podcastPath;

    return rssLink;
  }

  static String getDescription({required RssItem item}) {
    //Returns a rss description without the p tag.

    final doc = parse(item.description!);
    String newText = doc.body!.text;

    return newText;
  }
}
