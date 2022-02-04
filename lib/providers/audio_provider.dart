import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends BaseAudioHandler with ChangeNotifier {
  final _justAudio = AudioPlayer();

  bool _isPlaying = false;
  double _playbackSpeed = 1.0;

  // State of the player
  ProcessingState? _playState;

  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;

  final Duration _skipDuration = const Duration(milliseconds: 30000);

  bool get isPlaying => _isPlaying;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  Duration get skipDuration => _skipDuration;
  ProcessingState? get playState => _playState;
  double get playbackSpeed => _playbackSpeed;

  Future<void> init(String url) async {
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.rewind,
        MediaControl.play,
        MediaControl.fastForward,
      ],
      processingState: AudioProcessingState.idle,
      systemActions: {
        MediaAction.seek,
      },
    ));

    await setAudio(url);
    _audioState();
    _getAudioCurrentPosition();

    playbackState.add(playbackState.value.copyWith(
      processingState: AudioProcessingState.ready,
      systemActions: {
        MediaAction.seek,
      },
    ));

    notifyListeners();
  }

  // Set the audio source and set the totalDuration.
  Future<void> setAudio(String url) async {
    _totalDuration = (await _justAudio.setUrl(url))!;
    notifyListeners();
  }

  // Stop the audio.
  @override
  Future<void> stop() async {
    await _justAudio.stop();
    await super.stop();
  }

  // Play the audio.
  @override
  Future<void> play() async {
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [
        MediaControl.rewind,
        MediaControl.pause,
        MediaControl.fastForward,
      ],
      systemActions: {
        MediaAction.seek,
      },
    ));
    await _justAudio.play();
    await super.play();
  }

  // replay the audio.
  Future<void> restart() async {
    if (_playState == ProcessingState.completed && _isPlaying == false) {
      await seek(Duration.zero);
      await play();
    }
  }

  // Pause the audio.
  @override
  Future<void> pause() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [
        MediaControl.rewind,
        MediaControl.play,
        MediaControl.fastForward,
      ],
      systemActions: {
        MediaAction.seek,
      },
    ));
    await _justAudio.pause();
    await super.pause();
  }

  // Seek a particular part of the audio.Eg used for a slider.
  @override
  Future<void> seek(Duration position) async {
    await _justAudio.seek(position);
    await super.seek(position);
  }

  // speed up the audio
  void setPlaybackSpeed(double speed) {
    _justAudio.setSpeed(speed);
    _playbackSpeed = speed;
    super.setSpeed(speed);
    notifyListeners();
  }

  // Skip 30 sec forward
  @override
  Future<void> fastForward() async {
    // get the new position
    final newPosition = currentPosition + _skipDuration;

    // seek the postion
    _justAudio.seek(newPosition);

    // if the new postion is greater then the total duration.
    // return the total duration.
    if (newPosition > totalDuration) {
      _justAudio.seek(totalDuration);
    }
  }

  // rewind 30 sec.
  @override
  Future<void> rewind() async {
    // get the disired position
    final newPosition = currentPosition - _skipDuration;

    // seek the postion

    // if the new postion is greater then the total duration.
    // return the total duration.
    if (newPosition < Duration.zero) {
      await _justAudio.seek(Duration.zero);
      await super.seek(Duration.zero);
    } else {
      await _justAudio.seek(newPosition);
      await super.seek(newPosition);
    }
  }

  // Listen if the audio state is playing or paused.
  // Detects the state of the notification and updates the ui accordingly.
  void _audioState() {
    _justAudio.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      _playState = state.processingState;

      if (_playState == ProcessingState.completed) {
        _isPlaying = false;

        playbackState.add(playbackState.value.copyWith(
          playing: false,
          controls: [
            MediaControl.rewind,
            MediaControl.play,
            MediaControl.fastForward,
          ],
          systemActions: {
            MediaAction.seek,
          },
        ));
      }

      notifyListeners();
    });
  }

  // Listen to the audio position and set he current postistion.
  //Used for the slider
  void _getAudioCurrentPosition() {
    _justAudio.positionStream.listen((Duration duration) {
      _currentPosition = duration;

      notifyListeners();
    });
  }
}
