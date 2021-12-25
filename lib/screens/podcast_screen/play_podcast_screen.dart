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

  void _stop() {}
  void _play() {}
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
                    const _MySilder(),
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

  Widget _buildImage() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: const BoxDecoration(
        color: kBlue,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/meeting.jpg'),
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
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
        ),
        const Flexible(child: SizedBox(width: kBodyPadding)),
        Flexible(
          child: IconButton(
            icon: const Icon(
              FontAwesomeIcons.backward,
              size: 32,
            ),
            color: Colors.grey,
            onPressed: () {},
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
              _stop();
            } else {
              _play();
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
            onPressed: () {},
          ),
        ),
        const Flexible(child: SizedBox(width: kBodyPadding)),
        Flexible(
          child: IconButton(
            icon: const Icon(FontAwesomeIcons.stop, size: 32),
            color: Colors.grey,
            onPressed: () {
              setState(() {
                stopPlaying = true;
              });
            },
          ),
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
