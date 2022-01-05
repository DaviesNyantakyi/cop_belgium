import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/material.dart';

class TryAgainView extends StatelessWidget {
  final Function()? onPressed;
  const TryAgainView({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/error.png',
            height: 220,
            width: 220,
          ),
          const Text('OOops', style: kSFHeadLine1),
          const Text('Something went wrong.', style: kSFBody),
          const SizedBox(height: 30),
          Buttons.buildBtn(
            context: context,
            btnText: 'Try again',
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class NoPodcastsView extends StatelessWidget {
  final Function()? onPressed;
  const NoPodcastsView({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/no_podcasts.png',
            height: 220,
            width: 220,
          ),
          const Text('No podcasts found', style: kSFHeadLine1),
          const Text('Please try again later', style: kSFBody),
        ],
      ),
    );
  }
}

class NoSavedPodcastsView extends StatelessWidget {
  final Function()? onPressed;
  const NoSavedPodcastsView({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/no_podcasts.png',
            height: 220,
            width: 220,
          ),
          const Text('Bookmark empty', style: kSFHeadLine2),
          const Text('Get started by saving a podcast', style: kSFBody),
        ],
      ),
    );
  }
}
