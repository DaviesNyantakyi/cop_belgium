import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class PodcastCard extends StatelessWidget {
  final String image;
  final String title;
  final int episodes;
  final VoidCallback? onPressed;
  const PodcastCard({
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
        color: kDarkBlue,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kBlueLight.withOpacity(0.9),
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$episodes Episodes',
                    style: kSFSubtitle2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
