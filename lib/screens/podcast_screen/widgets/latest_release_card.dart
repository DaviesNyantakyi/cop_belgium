import 'package:cop_belgium/screens/podcast_screen/play_podcast_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LatestReleaseCard extends StatelessWidget {
  const LatestReleaseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //background image
      width: 380,
      height: 189,

      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/meeting.jpg'),
        ),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const PlayPodcastScreen(),
            ),
          );
        },
        style: kTextButtonStyle,
        child: Container(
          //this container is used for the gradient
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
            padding: const EdgeInsets.symmetric(vertical: 23)
                .copyWith(left: 22, right: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'The Paradigm',
                  style: kSFHeadLine2.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'What do we do with the passages in the Bible that are really difficult? What do we do with the passages in the Bible that are really difficult? ',
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
                        builder: (context) => const PlayPodcastScreen(),
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
