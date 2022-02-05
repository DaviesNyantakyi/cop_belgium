import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/providers/audio_provider.dart';
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
  int _selectedIndex = 0;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    final episode = Provider.of<Episode>(context, listen: false);

    await Provider.of<AudioProvider>(context, listen: false)
        .init(episode.audio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: Column(
            children: [
              const _BuildImage(),
              const SizedBox(height: 20),
              const _BuildTitle(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              const _BuildAudioControls(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BuildOptionsControls(),
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
}

class _BuildImage extends StatelessWidget {
  const _BuildImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = Provider.of<Episode>(context, listen: false).image;

    return Container(
      width: MediaQuery.of(context).size.width * 0.79,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        boxShadow: [kBoxShadow],
        color: kGrey,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(image!),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final episode = Provider.of<Episode>(context, listen: false);
    ProcessingState? state = Provider.of<AudioProvider>(context).playState;

    Widget _buildBufferingText() {
      Widget widget = Text(
        episode.author,
        style: kSFBody2,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
      if (state == ProcessingState.buffering) {
        widget = const Text('Buffering...');
      }

      return SizedBox(
        height: 20,
        child: widget,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          episode.title,
          style: kSFHeadLine3,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: kTextFieldSpacing),
        _buildBufferingText(),
      ],
    );
  }
}

class _BuildAudioControls extends StatefulWidget {
  const _BuildAudioControls({Key? key}) : super(key: key);

  @override
  State<_BuildAudioControls> createState() => _BuildAudioControlsState();
}

class _BuildAudioControlsState extends State<_BuildAudioControls> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
      child: Column(
        children: [
          _buildAudioControls(),
          const SizedBox(height: 20),
          _buildDurationText(),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return Slider(
      min: 0.0,
      max: Provider.of<AudioProvider>(context)
          .totalDuration
          .inMilliseconds
          .toDouble(),
      value: min(
          Provider.of<AudioProvider>(context)
              .currentPosition
              .inMilliseconds
              .toDouble(),
          Provider.of<AudioProvider>(context)
              .totalDuration
              .inMilliseconds
              .toDouble()),
      onChanged: (value) {
        final position = Duration(milliseconds: value.toInt());
        Provider.of<AudioProvider>(
          context,
          listen: false,
        ).seek(position);
      },
    );
  }

  Widget _buildDurationText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          FormalDates.getEpisodeDuration(
            duration: Provider.of<AudioProvider>(context).currentPosition,
          ),
        ),
        Text(
          FormalDates.getEpisodeDuration(
            duration: Provider.of<AudioProvider>(context).totalDuration,
          ),
        )
      ],
    );
  }

  Widget _buildAudioControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: SizedBox(
            width: 70,
            child: IconButton(
              icon: const Icon(
                Icons.replay_30_outlined,
                size: 35,
              ),
              color: kBlack,
              onPressed: () {
                Provider.of<AudioProvider>(context, listen: false).rewind();
              },
            ),
          ),
        ),
        SizedBox(
          width: 90,
          height: 80,
          child: _buildPlayPauseIcon(),
        ),
        Flexible(
          child: SizedBox(
            width: 70,
            child: IconButton(
              icon: const Icon(
                Icons.forward_30_outlined,
                size: 35,
              ),
              color: kBlack,
              onPressed: () {
                Provider.of<AudioProvider>(context, listen: false)
                    .fastForward();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayPauseIcon() {
    Widget widget = const Icon(Icons.play_arrow_outlined, size: 60);
    bool isPlaying = Provider.of<AudioProvider>(context).isPlaying;
    ProcessingState? state = Provider.of<AudioProvider>(context).playState;

    if (isPlaying) {
      widget = const Icon(
        Icons.pause_outlined,
        size: 60,
      );
    }

    if (state == ProcessingState.loading) {
      widget = kProgressIndicator;
    }

    return IconButton(
      icon: widget,
      onPressed: () {
        if (isPlaying) {
          Provider.of<AudioProvider>(context, listen: false).pause();
        } else {
          Provider.of<AudioProvider>(context, listen: false).play();
        }

        if (state == ProcessingState.completed && isPlaying == false) {
          Provider.of<AudioProvider>(context, listen: false).restart();
        }
      },
    );
  }
}

class _BuildOptionsControls extends StatefulWidget {
  const _BuildOptionsControls({Key? key}) : super(key: key);

  @override
  State<_BuildOptionsControls> createState() => _BuildOptionsControlsState();
}

class _BuildOptionsControlsState extends State<_BuildOptionsControls> {
  double playBackSpeed = 1.0;
  int sleepDuration = 30;
  Color color = kBlack.withOpacity(0.5);
  double spacing = 50;

  @override
  void initState() {
    playBackSpeed =
        Provider.of<AudioProvider>(context, listen: false).playbackSpeed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: 'Playback speed',
              child: IconButton(
                onPressed: () {
                  _showPlayBackBottomSheet(
                    context: context,
                    audioProvider: audioProvider,
                  );
                },
                icon: Icon(
                  Icons.speed_outlined,
                  size: 30,
                  color: color,
                ),
              ),
            ),
            // const SizedBox(width: spacing),
            // _sleepTimer(),
            SizedBox(width: spacing),
            IconButton(
              tooltip: 'About podcast',
              icon: Icon(
                Icons.info_outline_rounded,
                size: 30,
                color: color,
              ),
              onPressed: () {
                _showAboutBottomSheet(context: context);
              },
            ),
            SizedBox(width: spacing),
            IconButton(
              tooltip: 'Download',
              onPressed: () {},
              icon: Icon(
                Icons.file_download_outlined,
                size: 30,
                color: color,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAboutBottomSheet({
    required BuildContext context,
  }) {
    final episode = Provider.of<Episode>(context, listen: false);
    return showBottomSheet1(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              episode.title,
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              episode.description,
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showPlayBackBottomSheet(
      {required BuildContext context, required AudioProvider audioProvider}) {
    return showBottomSheet2(
      context: context,
      child: Center(
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (cntx, state) {
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
                      audioProvider.setPlaybackSpeed(playBackSpeed);
                      state(() {});
                    },
                  ),
                  const SizedBox(height: kButtonSpacing),
                  Buttons.buildOutlinedButton(
                    width: 100,
                    context: context,
                    child: const Text('Close', style: kSFBody),
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

  Widget _buildSleepButton({required int duration}) {
    return Buttons.buildOutlinedButton(
      child: const Text('Start', style: kSFBody),
      width: kButtonWidth,
      height: kButtonHeight,
      context: context,
      onPressed: () {
        sleepDuration = duration.toInt();
        setState(() {});
        Navigator.pop(context);
      },
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
                    min: 1,
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
                  _buildSleepButton(duration: selectedDuration.toInt()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _sleepTimer() {
    return IconButton(
      tooltip: 'Sleep timer',
      onPressed: () {
        _showSleepTimerBottomSheet(context: context);
      },
      icon: Icon(
        Icons.mode_night_outlined,
        size: 30,
        color: color,
      ),
    );
  }
}
