import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

class PodcastSeriesCard extends StatelessWidget {
  final String image;
  final String title;
  final int episodes;
  final VoidCallback? onPressed;
  const PodcastSeriesCard({
    Key? key,
    required this.image,
    required this.title,
    required this.episodes,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 143,
      decoration: BoxDecoration(
        color: kBlueDark,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            image,
          ),
        ),
      ),
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 65,
                width: 143,
                decoration: BoxDecoration(
                  color: kBlueLight.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: kSFSubtitle1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$episodes Episodes',
                      style: kSFSubtitle2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleSeriesPodcastCard extends StatelessWidget {
  final String image;
  final String title;
  final int episodes;
  final VoidCallback? onPressed;
  const SimpleSeriesPodcastCard({
    Key? key,
    required this.image,
    required this.title,
    required this.episodes,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 143,
      decoration: BoxDecoration(
        color: kBlueDark,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            image,
          ),
        ),
      ),
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 65,
                width: 143,
                decoration: BoxDecoration(
                  color: kBlueLight.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: kSFSubtitle1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$episodes Episodes',
                      style: kSFSubtitle2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
