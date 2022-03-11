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
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        boxShadow: [
          kBoxShadow,
        ],
        gradient: kPurpleGradient,
        borderRadius: const BorderRadius.all(
          Radius.circular(kCardRadius),
        ),
      ),
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(podcast.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kCardRadius),
                  bottomLeft: Radius.circular(kCardRadius),
                ),
              ),
              width: 120,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kCardContentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      podcast.title,
                      style: kSFBodyBold.copyWith(color: kWhite),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: kContentSpacing8),
                    Text(
                      podcast.description,
                      style: kSFBody2.copyWith(
                        color: kWhite,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    const Spacer(),
                    Text(
                      'Episodes ${podcast.episodes?.length}',
                      style: kSFCaption.copyWith(color: kWhite),
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
