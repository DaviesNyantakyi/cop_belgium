import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class AnnouncementsCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final VoidCallback onPressed;
  const AnnouncementsCard({
    Key? key,
    required this.title,
    required this.date,
    required this.onPressed,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        boxShadow: [
          boxShadow,
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
          padding: const EdgeInsets.only(
            left: 17,
            top: 14,
            right: 48,
            bottom: 21,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kSFBodyBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Flexible(child: SizedBox(height: 5)),
              Text(
                date,
                style: kSFUnderline,
              ),
              const Flexible(child: SizedBox(height: 9)),
              Text(
                description,
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
