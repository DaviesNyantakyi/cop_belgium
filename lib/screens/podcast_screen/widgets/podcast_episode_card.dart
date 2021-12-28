import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PodcastEpisodesCard extends StatelessWidget {
  final VoidCallback? onPressed;
  const PodcastEpisodesCard({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final episode = context.watch<Episode>();

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
          image: NetworkImage(
            episode.image!,
          ),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: kTextButtonStyle,
        child: Stack(
          children: [
            Positioned(
              right: 12.0,
              top: 14.0,
              child: Text(
                FormalDates.formatMs(
                  date: DateTime.fromMillisecondsSinceEpoch(episode.duration),
                ),
                style: kSFSubtitle2Bold.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                // bottom card
                height: 80,
                width: 143,
                decoration: const BoxDecoration(
                  color: kBlueDark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                    child: Text(
                      episode.title,
                      style: kSFSubtitle1.copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
