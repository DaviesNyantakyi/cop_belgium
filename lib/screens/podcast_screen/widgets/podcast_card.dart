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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            color: kBlue, // card background color if imgae is null
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(podcast.imageUrl),
            ),
          ),
          child: TextButton(
            style: kTextButtonStyle,
            onPressed: onPressed,
            child: Container(),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kBodyPadding),
          width: double.infinity,
          child: Text(
            podcast.title,
            style: kSFBodyBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
