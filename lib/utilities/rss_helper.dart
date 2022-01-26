import 'package:webfeed/domain/rss_item.dart';
import 'package:html/parser.dart' show parse;

class RssHelper {
  static String getDescription({required RssItem item}) {
    //Returns a rss description without the p tag.

    final doc = parse(item.description!);
    String newText = doc.body!.text;

    return newText;
  }
}
