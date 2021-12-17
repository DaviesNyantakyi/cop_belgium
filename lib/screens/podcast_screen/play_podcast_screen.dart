import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String _text =
    '''What do we do with the passages in the Bible that are really difficult? Violence, slavery, the treatment of women—what the Bible has to say about these topics has, at times, been misinterpreted and misused. ''';

class PlayPodcastScreen extends StatefulWidget {
  static String playPodcastScreen = 'playPodcastScreen';
  const PlayPodcastScreen({Key? key}) : super(key: key);

  @override
  State<PlayPodcastScreen> createState() => _PlayPodcastScreenState();
}

class _PlayPodcastScreenState extends State<PlayPodcastScreen> {
  bool isPlaying = false;
  bool stopPlaying = false;
  bool repeat = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  height: 360,
                  decoration: const BoxDecoration(
                    color: kBlue,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/meeting.jpg'),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildTitleDescription(),
                    const SizedBox(height: 32),
                    const _MySilder(),
                    const SizedBox(height: 32),
                    _buildMediaControl()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.redoAlt,
            size: 32,
          ),
          color: Colors.grey,
          onPressed: () {
            setState(() {
              repeat = !repeat;
            });
          },
        ),
        const SizedBox(width: kBodyPadding),
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.backward,
            size: 32,
          ),
          color: Colors.grey,
          onPressed: () {},
        ),
        const SizedBox(width: kBodyPadding),
        FloatingActionButton(
          backgroundColor: kDarkBlue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              isPlaying == true
                  ? FontAwesomeIcons.pause
                  : FontAwesomeIcons.play,
            ),
          ),
          onPressed: () {
            setState(() {
              isPlaying = !isPlaying;
              stopPlaying = false;
            });
          },
        ),
        const SizedBox(width: kBodyPadding),
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.forward,
            size: 32,
          ),
          color: Colors.grey,
          onPressed: () {},
        ),
        const SizedBox(width: kBodyPadding),
        IconButton(
          icon: const Icon(FontAwesomeIcons.stop, size: 32),
          color: Colors.grey,
          onPressed: () {
            setState(() {
              stopPlaying = true;
            });
          },
        ),
      ],
    );
  }
}

class _MySilder extends StatefulWidget {
  const _MySilder({Key? key}) : super(key: key);

  @override
  __MySilderState createState() => __MySilderState();
}

class __MySilderState extends State<_MySilder> {
  double _sliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: 0,
          max: 100,
          value: _sliderValue,
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
          },
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '00:00',
              style: kSFBody,
            ),
            Text(
              '00:00',
              style: kSFBody,
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildTitleDescription() {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          'Tree Of Life',
          style: kSFHeadLine2,
        ),
      ),
      const SizedBox(height: 12),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          _text,
          style: kSFBody,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      )
    ],
  );
}

dynamic _buildAppbar({required BuildContext context}) {
  return AppBar(
    leading: Container(
      margin: const EdgeInsets.symmetric(horizontal: kAppbarPadding),
      child: TextButton(
        style: kTextButtonStyle,
        child: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: kDarkBlue,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
