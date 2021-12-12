import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

class PodcastEpisodesCard extends StatelessWidget {
  final String image;
  final String title;
  final int episodes;
  final VoidCallback? onTap;
  const PodcastEpisodesCard({
    Key? key,
    required this.image,
    required this.title,
    required this.episodes,
    this.onTap,
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
          const Positioned(
            right: 12.0,
            top: 14.0,
            child: Text(
              '5:30',
              style: kSFSubtitle2,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 89,
              width: 143,
              decoration: BoxDecoration(
                color: kBlueLight.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: kSFSubtitle1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '12 December 2021',
                      style: kSFSubtitle2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: kBlueLight.withOpacity(0.3),
                onTap: onTap,
              ),
            ),
          )
        ],
      ),
    );
  }
}
