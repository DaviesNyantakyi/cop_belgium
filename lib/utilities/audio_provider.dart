import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/cupertino.dart';

import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  AudioPlayer? _audioPlayer;
  double totalDuration = 0;
  double currentposition = 0;
  String? totalDurationText;
  String? currentPostionText;

  void init() {
    _audioPlayer = AudioPlayer();
  }

  void play() {
    _audioPlayer?.play();
    notifyListeners();
  }

  void pause() {
    _audioPlayer?.pause();
    notifyListeners();
  }

  void setUrl({required String url}) {
    _audioPlayer!.setUrl(url);
    notifyListeners();
  }

  void getTotalDuration() {
    final Duration duration = _audioPlayer?.duration ?? Duration.zero;
    totalDuration = duration.inMilliseconds.toDouble();
    totalDurationText = FormalDates.getEpisodeDuration(duration: duration);
    notifyListeners();
    print(_audioPlayer?.audioSource);
  }
}
