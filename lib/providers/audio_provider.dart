// just_audio:
// playerStateStream: the state of the audio, if it's loading, paused, ready..

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends BaseAudioHandler with ChangeNotifier {
  final _justAudio = AudioPlayer();

  bool _isPlaying = false;
  double _playbackSpeed = 1.0;

  // State of the notifcation player
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

  Future<void> init({required String url, required MediaItem item}) async {
    try {
      // Show notification audio is loading.
      playbackState.add(PlaybackState(
        processingState: AudioProcessingState.loading,
        systemActions: {
          MediaAction.seek,
        },
      ));

      await _setMedia(url: url, item: item);

      _getAudioCurrentPosition();
      _audioState();

      await play();

      //Show notifcation audio is ready.
      playbackState.add(PlaybackState(
        playing: false,
        controls: [
          MediaControl.rewind,
          MediaControl.play,
          MediaControl.fastForward
        ],
        processingState: AudioProcessingState.ready,
        systemActions: {
          MediaAction.seek,
        },
      ));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    notifyListeners();
  }

  // Set the audio url, duration and add the epsiode details to the notication.
  Future<void> _setMedia({required String url, required MediaItem item}) async {
    try {
      _totalDuration = (await _justAudio.setUrl(url))!;

      // add the episode details to the notifcation
      mediaItem.add(item);
    } catch (e) {
      debugPrint(e.toString());

      rethrow;
    }
    notifyListeners();
  }

  // Stop the audio.
  @override
  Future<void> stop() async {
    // playbackState.add(PlaybackState(
    //   playing: true,
    //   processingState: AudioProcessingState.idle,
    // ));
    await _justAudio.stop();
    await super.stop();
  }

  // Play the audio.
  @override
  Future<void> play() async {
    playbackState.add(PlaybackState(
      playing: true,
      processingState: AudioProcessingState.ready,
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
    playbackState.add(PlaybackState(
      playing: false,
      processingState: AudioProcessingState.ready,
      controls: [
        MediaControl.rewind,
        MediaControl.play,
        MediaControl.fastForward,
      ],
      systemActions: {
        MediaAction.seek,
      },
    ));
    await _justAudio.pause(); // Pause just audio
    await super.pause(); // Pause notication
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

  //Listen to the just_audio player stream and update the Ui and notication.
  void _audioState() {
    _justAudio.playerStateStream.listen((state) {
      // playerStateStream listens to the current state of the button and the audio.

      // Listen to the state of the button when pressed.
      // This can be true or false when the button is pressed.

      // Also listen to the current state of the audio (ProcessingState).
      // This can be idle, loading, buffering, ready, completed.

      _isPlaying = state.playing; // Change the play and pause icon.
      _playState = state.processingState; // Change the processing state.

      // When the audio is complete.
      if (state.processingState == ProcessingState.completed) {
        // Change the icon to pause when the audio is complete.
        _isPlaying = false;

        // Upate the notifcation that the audi is complete.
        playbackState.add(PlaybackState(
          playing: false,
          processingState: AudioProcessingState.ready,
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
