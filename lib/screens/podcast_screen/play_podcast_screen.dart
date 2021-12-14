import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
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
                      image: AssetImage('assets/images/Rectangle 269.png'),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kBodyPadding,
                    vertical: kBodyPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 32),
                      const _MySilder(),
                      const SizedBox(height: 32),
                      _buildMediaControl()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaControl() {
    bool isPlaying = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.redoAlt,
            size: 32,
          ),
          color: Colors.grey,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.backward,
            size: 32,
          ),
          color: Colors.grey,
          onPressed: () {},
        ),
        FloatingActionButton(
          backgroundColor: kBlue,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              isPlaying == true
                  ? FontAwesomeIcons.pause
                  : FontAwesomeIcons.play,
            ),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.forward,
            size: 32,
          ),
          color: Colors.grey,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.stop, size: 32),
          color: Colors.grey,
          onPressed: () {},
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
          children: [
            Text(
              '00:00',
              style: kSFSubtitle2.copyWith(color: kBlue),
            ),
            Text(
              '00:00',
              style: kSFSubtitle2.copyWith(color: kBlue),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _buildTitle() {
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
          color: kBlueDark,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
