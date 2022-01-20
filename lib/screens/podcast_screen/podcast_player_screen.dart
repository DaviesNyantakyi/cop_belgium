import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
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
  String? title;
  String? description;
  Duration? newPosition;
  int seekDuration = 15000;

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
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      if (mounted) {
        episode = Provider.of<Episode>(context, listen: false);
      }

      Duration? duration = await player.setUrl(episode!.audio);
      title = episode!.title;
      description = episode!.title;

      getTotalDuration(duration: duration);
      getcurretPostion();
      if (mounted) {
        setState(() {});
      }
    });
  }

  void getTotalDuration({Duration? duration}) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(duration!.inMilliseconds.toInt());
    if (mounted) {
      setState(() {
        totalDurationText = FormalDates.calculateTime(date: date);
        totalDuration = duration.inMilliseconds.toDouble();
      });
    }
  }

  void getcurretPostion() {
    player.positionStream.listen((Duration duration) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds.toInt());
      if (mounted) {
        setState(() {
          currentposition = duration.inMilliseconds.toDouble();
          currentPostionText = FormalDates.calculateTime(date: date);
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
                _buildImage(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildTitleDescription(),
                    const SizedBox(height: 32),
                    _slider(),
                    const SizedBox(height: 32),
                    _buildMediaControls()
                  ],
                ),
              ],
            ),
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
        const SizedBox(height: 8),
        _buildDurationText()
      ],
    );
  }

  Widget _buildDurationText() {
    if (episode != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currentPostionText!,
            style: kSFBody,
          ),
          Text(
            totalDurationText!,
            style: kSFBody,
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SkeletonItem(
            child: Text(
              '00:00',
              style: kSFBody,
            ),
          ),
          SkeletonItem(
            child: Text(
              '00:00',
              style: kSFBody,
            ),
          )
        ],
      );
    }
  }

  Widget _buildImage() {
    if (episode?.image != null) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.37,
        decoration: BoxDecoration(
          color: kGrey,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(episode!.image!),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      );
    } else {
      return SkeletonItem(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.40,
          decoration: const BoxDecoration(
            color: kBlue,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      );
    }
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: TextButton(
        child: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: kBlueDark,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }

  Widget _buildMediaControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: IconButton(
            icon: const Icon(
              FontAwesomeIcons.backward,
              size: 35,
            ),
            color: kBlueDark,
            onPressed: episode != null
                ? () {
                    var newduration =
                        player.position - Duration(milliseconds: seekDuration);

                    if (newduration > Duration.zero) {
                      player.seek(newduration);
                    }
                    if (newduration.inMilliseconds < 0) {
                      player.seek(Duration.zero);
                    }
                  }
                : null,
          ),
        ),
        const Flexible(child: SizedBox(width: 30)),
        player.processingState == ProcessingState.loading ||
                player.processingState == ProcessingState.buffering
            ? kCircularProgress
            : IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  isPlaying == true
                      ? FontAwesomeIcons.pause
                      : FontAwesomeIcons.play,
                  size: 45,
                ),
                color: kBlueDark,
                onPressed: episode != null
                    ? () {
                        if (isPlaying) {
                          stop();
                        } else {
                          play();
                        }

                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      }
                    : null,
              ),
        const Flexible(child: SizedBox(width: 30)),
        Flexible(
          child: IconButton(
            icon: const Icon(
              FontAwesomeIcons.forward,
              size: 35,
            ),
            color: kBlueDark,
            onPressed: episode != null
                ? () {
                    newPosition =
                        player.position + Duration(milliseconds: seekDuration);
                    player.seek(newPosition);

                    if (newPosition! > player.duration!) {
                      player.seek(player.duration);
                    }
                  }
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildTitleDescription() {
    if (episode != null) {
      return TextButton(
        style: kTextButtonStyle,
        onPressed: () {
          _showBottomSheet(
            context: context,
            title: title!,
            description: description!,
          );
        },
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title!,
                style: kSFHeadLine2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                description!,
                style: kSFBody,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              '...',
              style: kSFHeadLine2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              '...',
              style: kSFBody,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }
  }

  Future<void> _showBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    return showMyBottomSheet(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: kSFHeadLine2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              style: kSFBody,
            ),
          ),
        ],
      ),
    );
  }
}
