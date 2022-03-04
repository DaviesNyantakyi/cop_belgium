import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;
  final Function()? onPressed;
  const EpisodeCard({
    Key? key,
    this.onPressed,
    required this.episode,
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
                  image: NetworkImage(episode.image),
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
                      episode.title,
                      style: kSFBodyBold.copyWith(color: kWhite),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      episode.description,
                      style: kSFBody2.copyWith(
                        color: kWhite,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      FormalDates.getEpisodeDuration(
                        duration: episode.duration,
                      ),
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
