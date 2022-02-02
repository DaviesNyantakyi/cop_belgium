import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:just_audio/just_audio.dart';

// Was abstracting the audio player functionality
class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final int _seekDuration = 30000; // 30 sec fast forward and backward
  bool _isPlaying = false;
  ProcessingState? _playerState;

  double _playbackSpeed = 1.0;

  Duration _totalDurtion = const Duration(milliseconds: 0);
  Duration _currentPostion = const Duration(milliseconds: 0);

  Duration get totalDuration => _totalDurtion;
  Duration get currentPostion => _currentPostion;
  ProcessingState? get state => _playerState;
  bool get isPlaying => _isPlaying;
  double get playbackSpeed => _playbackSpeed;

  void init() {
    _audioPlayer.positionStream.listen((duration) {
      _currentPostion = duration;
      notifyListeners();
    });

    _getPlayerState();
  }

  Future<void> play() async {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  Future<void> setUrl({required String url}) async {
    _totalDurtion = (await _audioPlayer.setUrl(url))!;
    notifyListeners();
  }

  void seek({required int newPosition}) {
    // skipping
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
    // the current state of the audio
    _audioPlayer.processingStateStream.listen((state) {
      _playerState = state;

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    notifyListeners();
    super.dispose();
  }

  void setPlaybackSpeed({required double speed}) {
    _audioPlayer.setSpeed(speed);
    _playbackSpeed = speed;
    notifyListeners();
  }
}
