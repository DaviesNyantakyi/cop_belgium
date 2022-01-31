import 'package:webfeed/domain/rss_item.dart';
import 'package:html/parser.dart' show parse;

class RssHelper {
  static String getDescription({required RssItem item}) {
    //Returns a rss description without the p tag.
    final String descritpion = item.itunes?.summary ?? item.description ?? '';
    final doc = parse(descritpion, generateSpans: true, encoding: 'UTF-8');
    String newText = doc.body?.text ?? '';

    return newText;
  }
}
