import 'package:cop_belgium/models/announcement_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class AnnouncementsCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback onPressed;
  const AnnouncementsCard({
    Key? key,
    required this.announcement,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildDate() {
      String time = timeago.format(announcement.dateTime);

      if (time.contains('years ago') || time.contains('about a year ago')) {
        time = FormalDates.formatEDmyyyyHm(date: announcement.dateTime);
      }

      return Text(
        time,
        style: kSFCaption,
      );
    }

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        boxShadow: [
          kBoxShadow,
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: kTextButtonStyle,
        child: Padding(
          padding: const EdgeInsets.all(kCardContentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                announcement.title,
                style: kSFBodyBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: kContentSpacing12),
              _buildDate(),
              const SizedBox(height: 14),
              Text(
                announcement.description,
                style: kSFBody,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
