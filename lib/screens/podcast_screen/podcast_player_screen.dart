import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/providers/audio_provider.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/utilities/save_episode.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PodcastPlayerScreen extends StatefulWidget {
  static String podcastPlayerScreen = 'podcastPlayerScreen';
  const PodcastPlayerScreen({Key? key}) : super(key: key);

  @override
  State<PodcastPlayerScreen> createState() => _PodcastPlayerScreenState();
}

class _PodcastPlayerScreenState extends State<PodcastPlayerScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    final episode = Provider.of<Episode>(context, listen: false);

    await Provider.of<AudioProvider>(context, listen: false)
        .init(episode.audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kBodyPadding),
          child: IntrinsicHeight(
            child: Column(
              children: [
                const _BuildImage(),
                const SizedBox(height: kContentSpacing32),
                const _BuildTitle(),
                Expanded(child: Container(height: 70)),
                const _BuildAudioControls(),
              ],
            ),
          ),
        ),
      ),
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
      actions: [
        Container(
          width: 55,
          padding: const EdgeInsets.only(right: kAppbarPadding),
          child: TextButton(
            style: kTextButtonStyle,
            child: const Icon(
              Icons.info_outline_rounded,
              size: 30,
              color: kBlack,
            ),
            onPressed: () {
              _showAboutBottomSheet(context: context);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showAboutBottomSheet({
    required BuildContext context,
  }) {
    return showNormalBottomSheet(
      context: context,
      child: Consumer<Episode>(builder: (context, episode, _) {
        return Column(
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
        );
      }),
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
  double playBackSpeed = 1.0;
  double containerSize = 100;
  bool isLoading = false;

  @override
  void initState() {
    playBackSpeed =
        Provider.of<AudioProvider>(context, listen: false).playbackSpeed;
    test();
    super.initState();
  }

  Future<void> test() async {
    final episode = Provider.of<Episode>(context, listen: false);

    // final x = getEpisodePath(
    //     path: '$podcastPath/${episode.podcastName}/${episode.title}.mp3');

    // if (await x.exists()) {
    //   print('oke');
    // } else {
    //   print('false');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
      child: Column(
        children: [
          const SizedBox(height: kContentSpacing32),
          _buildDurationText(),
          _buildSlider(),
          _buildAudioControls(),
        ],
      ),
    );
  }

  Widget _buildPlaybackSpeed() {
    return Consumer<AudioProvider>(builder: (context, audioProvider, _) {
      return Expanded(
        child: SizedBox(
          width: containerSize,
          child: TextButton(
            style: kTextButtonStyle,
            child: const Icon(
              Icons.speed_outlined,
              size: 35,
              color: kBlack,
            ),
            onPressed: () {
              _showPlayBackBottomSheet(
                context: context,
                audioProvider: audioProvider,
              );
            },
          ),
        ),
      );
    });
  }

  Future<void> _showPlayBackBottomSheet(
      {required BuildContext context, required AudioProvider audioProvider}) {
    return showSmallBottomSheet(
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
                  const SizedBox(height: kContentSpacing32),
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

  Widget _buildAudioControls() {
    return Consumer<Episode>(builder: (context, episode, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPlaybackSpeed(),
          const SizedBox(width: kContentSpacing12),
          _buildRewindButton(),
          _buildPlayPauseIcon(),
          _buildFastFowardButton(),
          const SizedBox(width: kContentSpacing12),
          _buildDownloadButton(episode: episode),
        ],
      );
    });
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

  Widget _buildFastFowardButton() {
    return Expanded(
      child: SizedBox(
        width: containerSize,
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            Icons.forward_30_outlined,
            size: 35,
            color: kBlack,
          ),
          onPressed: () {
            Provider.of<AudioProvider>(context, listen: false).fastForward();
          },
        ),
      ),
    );
  }

  Widget _buildRewindButton() {
    return Expanded(
      child: SizedBox(
        width: containerSize,
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            Icons.replay_30_outlined,
            size: 35,
            color: kBlack,
          ),
          onPressed: () {
            Provider.of<AudioProvider>(context, listen: false).rewind();
          },
        ),
      ),
    );
  }

  Widget _buildPlayPauseIcon() {
    IconData icon = Icons.play_arrow_outlined;
    bool isPlaying = Provider.of<AudioProvider>(context).isPlaying;
    ProcessingState? state = Provider.of<AudioProvider>(context).playState;

    if (state == ProcessingState.loading) {
      return Expanded(
        flex: 2,
        child: SizedBox(
          height: containerSize,
          width: containerSize,
          child: const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: kCircularProgressIndicator,
            ),
          ),
        ),
      );
    }

    if (isPlaying) {
      icon = Icons.pause_outlined;
    }

    return Expanded(
      flex: 2,
      child: SizedBox(
        height: containerSize,
        width: containerSize,
        // color: Colors.pink.shade100,

        child: TextButton(
          style: kTextButtonStyle,
          child: Icon(
            icon,
            size: 100,
            color: kBlack,
          ),
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
        ),
      ),
    );
  }

  Widget _buildDownloadButton({required Episode episode}) {
    if (isLoading) {
      return Expanded(
        child: SizedBox(
          width: containerSize,
          child: const Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: kCircularProgressIndicator,
            ),
          ),
        ),
      );
    }
    return Expanded(
      child: SizedBox(
        width: containerSize,
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            Icons.file_download_outlined,
            size: 35,
            color: kBlack,
          ),
          onPressed: () async {
            isLoading = true;
            setState(() {});
            final x = await savePodcastEpisode(
              fileName: episode.title,
              direcotryFolder: 'Podcasts/${episode.podcastName}',
              url: episode.audioUrl,
              fileExtension: '.mp3',
            );

            setState(() {});
            isLoading = false;
          },
        ),
      ),
    );
  }
}
