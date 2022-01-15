import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class PodcastCard extends StatelessWidget {
  final Podcast podcast;
  final Function()? onPressed;
  const PodcastCard({
    Key? key,
    this.onPressed,
    required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 200,
      decoration: BoxDecoration(
        color: kBlue, // card background color if imgae is null
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(podcast.image),
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
                      podcast.title,
                      style: kSFOverline.copyWith(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${podcast.episodes?.length ?? 0} Episodes',
                      style: kSFOverline.copyWith(color: Colors.white),
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
