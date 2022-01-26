import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/services/podcast_service.dart';
import 'package:flutter/foundation.dart';

class PodcastProvider extends ChangeNotifier {
  List<Podcast> podcasts = [];
  List<Podcast> savedPodcasts = [];
  bool hasError = false;
  bool isLoading = false;

  Future<List<Podcast>> getPodcasts() async {
    try {
      podcasts = [];
      hasError = false;
      isLoading = true;

      final allPodcats = await PodcastService().getPodcast();

      podcasts.addAll(allPodcats);
      isLoading = false;
      notifyListeners();
      return podcasts;
    } catch (e) {
      isLoading = false;
      hasError = true;
      notifyListeners();
      debugPrint(e.toString());
      rethrow;
    }
  }
}
