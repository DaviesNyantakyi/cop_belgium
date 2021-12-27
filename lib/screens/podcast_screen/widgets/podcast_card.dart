import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_image.dart';

class PodcastCard extends StatelessWidget {
  final String? title;
  final int? episodes;
  final String? image;
  final Function()? onPressed;
  const PodcastCard({
    Key? key,
    this.onPressed,
    this.title,
    this.episodes,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      decoration: const BoxDecoration(
        color: kBlueLight, // card background color
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/Rectangle 269.png'),
        ),
      ),
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // bottom card
              height: 70,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kBlueDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$title',
                      style: kSFSubtitle1.copyWith(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$episodes Episodes',
                      style: kSFSubtitle2.copyWith(color: Colors.white),
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
