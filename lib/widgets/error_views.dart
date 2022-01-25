import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/material.dart';

class TryAgainView extends StatelessWidget {
  final Function()? onPressed;
  final Color btnColor;
  const TryAgainView({
    Key? key,
    this.onPressed,
    required this.btnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kBodyPadding,
          horizontal: kBodyPadding,
        ),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Image.asset(
                'assets/images/error.png',
                height: 220,
                width: 220,
              ),
            ),
            const Flexible(child: Text('OOops', style: kSFHeadLine2)),
            const Flexible(
                child: Text('Something went wrong.', style: kSFBody)),
            const Flexible(child: SizedBox(height: 30)),
            Flexible(
              child: Buttons.buildBtn(
                width: double.infinity,
                color: btnColor,
                context: context,
                btnText: 'Try again',
                onPressed: onPressed,
              ),
            ),
          ],
        ),
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
          const Text('No podcasts found', style: kSFHeadLine2),
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
          const Text('Bookmark Empty', style: kSFHeadLine2),
          const Text('Get started by saving a podcast', style: kSFBody),
        ],
      ),
    );
  }
}

class NoFastingHistoryView extends StatelessWidget {
  final Function()? onPressed;
  const NoFastingHistoryView({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/no_fast_added.png',
              height: 220,
              width: 220,
            ),
            const Text('No Fasting History', style: kSFHeadLine2),
            const Text('Get started by Fasting', style: kSFBody),
          ],
        ),
      ),
    );
  }
}
