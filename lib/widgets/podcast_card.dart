import 'package:cop_belgium/utilities/colors.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

class PodcastCard extends StatelessWidget {
  final String image;
  final String title;
  final int episodes;
  const PodcastCard({
    Key? key,
    required this.image,
    required this.title,
    required this.episodes,
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
    );
  }
}
