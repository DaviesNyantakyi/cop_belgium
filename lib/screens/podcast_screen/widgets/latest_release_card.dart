import 'package:cached_network_image/cached_network_image.dart';
import 'package:cop_belgium/models/podcast_model.dart';
import 'package:cop_belgium/screens/all_screens.dart';
import 'package:cop_belgium/screens/podcast_screen/podcast_player_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FeaturedReleaseCard extends StatelessWidget {
  const FeaturedReleaseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // latest episode
    final episode = Provider.of<List<Podcast>>(context, listen: false)
        .first
        .episodes!
        .first;

    return Container(
      //background image
      width: 380,
      height: 189,

      decoration: BoxDecoration(
        color: kGreyLight,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(episode.image!),
        ),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => Provider.value(
                value: episode,
                child: const PodcastPlayerScreen(),
              ),
            ),
          );
        },
        style: kTextButtonStyle,
        child: Container(
          //this container is used for the gradient
          width: 380,
          height: 189,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.1),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 22, right: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  episode.title,
                  style: kSFHeadLine2.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  episode.description,
                  style: kSFBody.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                _buildPlayBt(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => Provider.value(
                          value: episode,
                          child: const PodcastPlayerScreen(),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayBt({VoidCallback? onPressed}) {
    return SizedBox(
      height: 40,
      width: 123,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 100,
              child: Text(
                'Listen Now',
                style: kSFBody.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Expanded(child: SizedBox(width: 10)),
            const Expanded(
              child: Icon(
                FontAwesomeIcons.chevronRight,
                size: 16,
                color: kBlueDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LatestReleaseCardSkeleton extends StatelessWidget {
  const LatestReleaseCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //background image
      width: 380,
      height: 189,
      decoration: const BoxDecoration(
        color: kGreyLight,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: null,
    );
  }
}
