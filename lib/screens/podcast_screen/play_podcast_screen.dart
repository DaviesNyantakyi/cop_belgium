import 'dart:math';

import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class PlayPodcastScreen extends StatefulWidget {
  static String playPodcastScreen = 'playPodcastScreen';
  const PlayPodcastScreen({Key? key}) : super(key: key);

  @override
  State<PlayPodcastScreen> createState() => _PlayPodcastScreenState();
}

class _PlayPodcastScreenState extends State<PlayPodcastScreen> {
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
      episode = Provider.of<Episode>(context, listen: false);

      Duration? duration = await player.setUrl(episode!.audio);
      title = episode!.title;
      description = episode!.title;

      getTotalDuration(duration: duration);
      getcurretPostion();
      setState(() {});
    });
  }

  void getTotalDuration({Duration? duration}) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(duration!.inMilliseconds.toInt());
    setState(() {
      totalDurationText = FormalDates.formatMs(date: date);
      totalDuration = duration.inMilliseconds.toDouble();
    });
  }

  void getcurretPostion() {
    player.positionStream.listen((Duration duration) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds.toInt());
      setState(() {
        currentposition = duration.inMilliseconds.toDouble();
        currentPostionText = FormalDates.formatMs(date: date);
      });
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
      appBar: buildAppbar(context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kBodyPadding, vertical: kBodyPadding),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currentPostionText ?? '00:00',
              style: kSFBody,
            ),
            Text(
              totalDurationText ?? '...',
              style: kSFBody,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (episode?.image != null) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.40,
        decoration: BoxDecoration(
          color: kBlue,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(episode!.image!),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
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

  dynamic buildAppbar({required BuildContext context}) {
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: kBlueDark,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              size: 32,
            ),
            color: Colors.grey,
            onPressed: () {
              var x = player.position - const Duration(milliseconds: 10000);

              if (x > Duration.zero) {
                player.seek(x);
              }
              if (x.inMilliseconds < 0) {
                player.seek(Duration.zero);
              }
            },
          ),
        ),
        const Flexible(child: SizedBox(width: kBodyPadding)),
        IconButton(
          icon: Icon(
            isPlaying == true ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
            size: 32,
          ),
          color: Colors.grey,
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
        const Flexible(child: SizedBox(width: kBodyPadding)),
        Flexible(
          child: IconButton(
            icon: const Icon(
              FontAwesomeIcons.forward,
              size: 32,
            ),
            color: Colors.grey,
            onPressed: () {
              newPosition =
                  player.position + const Duration(milliseconds: 10000);
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

  Widget _buildTitleDescription() {
    return TextButton(
      style: kTextButtonStyle,
      onPressed: () {
        _showBottomSheet(
            context: context,
            title: title ?? '...',
            description: description ?? '...');
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title ?? '...',
              style: kSFHeadLine2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              description ?? '...',
              style: kSFBody,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
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
