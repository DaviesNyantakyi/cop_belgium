import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/utilities/audio_provider.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
//TODO: Keeps loading when the screen is opened for the first time and the slider is moved

class PodcastPlayerScreen extends StatefulWidget {
  static String podcastPlayerScreen = 'podcastPlayerScreen';
  const PodcastPlayerScreen({Key? key}) : super(key: key);

  @override
  State<PodcastPlayerScreen> createState() => _PodcastPlayerScreenState();
}

class _PodcastPlayerScreenState extends State<PodcastPlayerScreen> {
  AudioPlayer player = AudioPlayer();

  bool isPlaying = false;
  String? totalDurationText;
  String? currentPostionText;
  double totalDuration = 0;
  double currentposition = 0;
  Episode? episode;
  double playBackSpeed = 1.0;
  bool isMuted = false;
  int sleepDuration = 30;

  Duration? newPosition;
  int seekDuration = 15000; // 15 sec fast forward and backward

  Future<void> stop() async {
    await player.stop();
  }

  Future<void> play() async {
    await player.play();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (mounted) {
      episode = Provider.of<Episode>(context, listen: false);
    }

    final duration = await player.setUrl(episode!.audio);

    getTotalDuration(duration: duration);
    getcurretPostion();

    if (mounted) {
      setState(() {});
    }
  }

  void getTotalDuration({Duration? duration}) {
    totalDuration = duration?.inMilliseconds.toDouble() ?? 0;
    totalDurationText = FormalDates.getEpisodeDuration(duration: duration!);
  }

  void getcurretPostion() {
    player.positionStream.listen((Duration duration) {
      if (mounted) {
        setState(() {
          currentPostionText =
              FormalDates.getEpisodeDuration(duration: duration);
          currentposition = duration.inMilliseconds.toDouble();

          // changes the playback speed if is not the same
          if (playBackSpeed != player.speed) {
            player.setSpeed(playBackSpeed);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kBodyPadding, vertical: kBodyPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _BuildImage(episode: episode!),
                const SizedBox(height: 20),
                _BuildTitle(episode: episode),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                _buildOptionsControls(),
                _slider(),
                const SizedBox(height: 15),
                _buildMediaControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsControls() {
    Color color = kBlack.withOpacity(0.5);
    const spacing = 15.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tooltip(
          message: 'Playback speed',
          child: IconButton(
            onPressed: () {
              _showPlayBackBottomSheet(context: context, episode: episode);
            },
            icon: Icon(
              Icons.speed_outlined,
              size: 30,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: spacing),
        Tooltip(
          message: 'Sleep timer',
          child: IconButton(
            onPressed: () {
              _showSleepTimerBottomSheet(context: context);
            },
            icon: Icon(
              Icons.mode_night_outlined,
              size: 30,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: spacing),
        Tooltip(
          message: 'About podcast',
          child: IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              size: 30,
              color: color,
            ),
            onPressed: () {
              _showAboutBottomSheet(context: context, episode: episode);
            },
          ),
        ),
        const SizedBox(width: spacing),
        Tooltip(
          message: 'Volume',
          child: IconButton(
            onPressed: () {
              isMuted = !isMuted;
              if (isMuted) {
                player.setVolume(0);
              } else {
                player.setVolume(1);
              }

              setState(() {});
            },
            icon: Icon(
              isMuted ? Icons.volume_off_outlined : Icons.volume_up_outlined,
              size: 30,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: spacing),
        Tooltip(
          message: 'Download',
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.file_download_outlined,
              size: 30,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showAboutBottomSheet({
    required BuildContext context,
    required Episode? episode,
  }) {
    return showBottomSheet1(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              episode?.title ?? '',
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              episode?.description ?? '',
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showPlayBackBottomSheet({
    required BuildContext context,
    required Episode? episode,
  }) {
    return showBottomSheet2(
      context: context,
      child: Center(
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Playback speed',
                    style: kSFHeadLine3.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${double.parse(playBackSpeed.toStringAsFixed(2))} x',
                    style: kSFHeadLine2,
                  ),
                  const SizedBox(height: 16),
                  SfSlider(
                    activeColor: kBlue,
                    inactiveColor: Colors.grey.shade300,
                    min: 0.5,
                    max: 3.0,
                    value: double.parse(playBackSpeed.toStringAsFixed(2)),
                    interval: 0.5,
                    showTicks: true,
                    showLabels: true,
                    stepSize: 0.1,
                    minorTicksPerInterval: 5,
                    onChanged: (value) {
                      playBackSpeed = value;
                      state(() {});
                    },
                  ),
                  const SizedBox(height: kButtonSpacing),
                  Buttons.buildBtn(
                    width: 100,
                    context: context,
                    btnText: 'Close',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showSleepTimerBottomSheet({required BuildContext context}) {
    double selectedDuration = 30;
    return showBottomSheet2(
      context: context,
      child: Center(
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sleep timer',
                    style: kSFHeadLine3.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${selectedDuration.toStringAsFixed(0)} min',
                    style: kSFHeadLine2,
                  ),
                  const SizedBox(height: 16),
                  SfSlider(
                    activeColor: kBlue,
                    inactiveColor: Colors.grey.shade300,
                    min: 5.0,
                    max: 105.0,
                    value: selectedDuration,
                    stepSize: 5,
                    interval: 5,
                    showTicks: true,
                    onChanged: (dynamic value) {
                      selectedDuration = value;
                      state(() {});
                    },
                  ),
                  const SizedBox(height: kButtonSpacing),
                  Buttons.buildBtn(
                    width: 100,
                    context: context,
                    btnText: 'Start',
                    onPressed: () async {
                      final duration =
                          Duration(minutes: selectedDuration.toInt());
                      Timer.periodic(duration, (timer) {
                        //The timer function will be called if the timer is complete.
                        player.stop();
                      });
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _slider() {
    return Column(
      children: [
        Slider(
          min: 0.0,
          max: totalDuration,
          value: min(
              currentposition, player.duration?.inMilliseconds.toDouble() ?? 0),
          // An error will accur when the currentposition and the slider reaches the end because the currentposition is greater then the totalDuratio.
          // The min function is used. This returns the min value between 2 numbers.
          // When the player reaches the end and the current position is greater the the total duration the total duration will be return as the value.

          onChanged: (value) {
            player.setVolume(0.0);
            player.seek(Duration(milliseconds: value.toInt()));
            player.setVolume(1);
          },
          onChangeEnd: (value) {},
        ),
        _buildDurationText()
      ],
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: TextButton(
        child: kBackButton(context: context),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }

  Widget _buildDurationText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currentPostionText ?? '',
          style: kSFBody2,
        ),
        Text(
          totalDurationText ?? '',
          style: kSFBody2,
        )
      ],
    );
  }

  Widget _buildMediaControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: IconButton(
            icon: const Icon(
              Icons.replay_30_outlined,
              size: 35,
            ),
            color: kBlack,
            onPressed: () {
              var newduration =
                  player.position - Duration(milliseconds: seekDuration);

              if (newduration > Duration.zero) {
                player.seek(newduration);
              }
              if (newduration.inMilliseconds < 0) {
                player.seek(Duration.zero);
              }
            },
          ),
        ),
        const Flexible(child: SizedBox(width: 30)),
        player.processingState == ProcessingState.loading ||
                player.processingState == ProcessingState.buffering
            ? kProgressIndicator
            : IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  isPlaying == true
                      ? Icons.pause_outlined
                      : Icons.play_arrow_outlined,
                  size: 50,
                ),
                color: kBlack,
                onPressed: () {
                  if (isPlaying) {
                    stop();
                  } else {
                    play();
                  }
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
        const Flexible(child: SizedBox(width: 30)),
        Flexible(
          child: IconButton(
            icon: const Icon(
              Icons.forward_30_outlined,
              size: 35,
            ),
            color: kBlack,
            onPressed: () {
              newPosition =
                  player.position + Duration(milliseconds: seekDuration);
              player.seek(newPosition);

              if (newPosition! > player.duration!) {
                player.seek(player.duration);
              }
            },
          ),
        ),
      ],
    );
  }
}

class _BuildImage extends StatelessWidget {
  final Episode episode;
  const _BuildImage({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.79,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        boxShadow: [kBoxShadow],
        color: kGrey,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(episode.image!),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

class _BuildTitle extends StatelessWidget {
  final Episode? episode;
  const _BuildTitle({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            episode?.title ?? '',
            style: kSFHeadLine3,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'by ${episode?.author ?? ''}',
            style: kSFBody2,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
