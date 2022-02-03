import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';

import 'package:just_audio/just_audio.dart';

// Was abstracting the audio player functionality
class AudioProvider extends ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();

  // skip the audio 30 sec forward or backward
  final int _seekDuration = 30000;
  bool _isPlaying = false;

  // The current audio state. This can be: loading, buffering, idle, ready, completed
  ProcessingState? _playerState;

  // the value used to speed up the audio
  double _playbackSpeed = 1.0;

  // the total audio duration
  Duration _totalDurtion = const Duration(milliseconds: 0);

  // the current audio postion
  Duration _currentPostion = const Duration(milliseconds: 0);

  Duration get totalDuration => _totalDurtion;
  Duration get currentPostion => _currentPostion;
  ProcessingState? get state => _playerState;
  bool get isPlaying => _isPlaying;
  double get playbackSpeed => _playbackSpeed;

  AudioProvider() {
    // listen to the audio position changes.
    _audioPlayer.positionStream.listen((duration) {
      _currentPostion = duration;
      notifyListeners();
    });

    // listen to the player state changes.
    _getPlayerState();
  }

  // Play or pause the audio depending on isPlaying
  Future<void> play() async {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    _isPlaying = !_isPlaying;

    notifyListeners();
  }

  // set the audio you want to play
  Future<void> setUrl({required String url}) async {
    _totalDurtion = (await _audioPlayer.setUrl(url))!;
    notifyListeners();
  }

  // skip to the postion you want. for eg slider
  void seek({required int newPosition}) {
    _audioPlayer.seek(Duration(milliseconds: newPosition));
    notifyListeners();
  }

  void fastRewind() {
    // subtract the 30 sec from the current postion. this will give use a new position.
    var newduration = _currentPostion - Duration(milliseconds: _seekDuration);

    // Then seek the new postion
    if (newduration > Duration.zero) {
      _audioPlayer.seek(newduration);
    }
    if (newduration.inMilliseconds < 0) {
      _audioPlayer.seek(Duration.zero);
    }

    notifyListeners();
  }

  void fastForward() {
    // add 30 sec to the current postion. this will give use a new position.
    var newduration = _currentPostion + Duration(milliseconds: _seekDuration);

    // Then seek the new postion
    _audioPlayer.seek(newduration);

    // seek the total audio duration if the new duration is greater then the audio duration
    if (newduration > _totalDurtion) {
      _audioPlayer.seek(_totalDurtion);
    }

    notifyListeners();
  }

  void _getPlayerState() {
    // the current audio state. This can be: loading, buffering, idle, ready, completed

    _audioPlayer.processingStateStream.listen((state) {
      _playerState = state;

      notifyListeners();
    });
  }

  Future<void> close() async {
    _audioPlayer.dispose();
  }

  // speed up the audio
  void setPlaybackSpeed({required double speed}) {
    _audioPlayer.setSpeed(speed);
    _playbackSpeed = speed;
    notifyListeners();
  }
}
