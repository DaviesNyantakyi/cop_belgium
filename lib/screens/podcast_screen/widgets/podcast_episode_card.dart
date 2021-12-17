import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class PodcastEpisodesCard extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String length;
  final VoidCallback? onPressed;
  const PodcastEpisodesCard({
    Key? key,
    required this.image,
    required this.title,
    this.onPressed,
    required this.date,
    required this.length,
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
        onPressed: onPressed,
        style: kTextButtonStyle,
        child: Stack(
          children: [
            Positioned(
              right: 12.0,
              top: 14.0,
              child: Text(
                length,
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

                height: 89,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: kSFSubtitle1.copyWith(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        date,
                        style: kSFSubtitle2.copyWith(color: Colors.white),
                      ),
                    ],
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
