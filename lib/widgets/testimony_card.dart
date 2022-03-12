import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class TestimonyCard extends StatelessWidget {
  final TestimonyInfo testimony;
  final VoidCallback onPressed;
  final VoidCallback onPressedLike;
  const TestimonyCard({
    Key? key,
    required this.testimony,
    required this.onPressed,
    required this.onPressedLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildDate() {
      String time = timeago.format(testimony.date!);

      if (time.contains('years ago') || time.contains('about a year ago')) {
        time = FormalDates.formatEDmyyyyHm(date: testimony.date);
      }

      return Text(
        time,
        style: kSFCaption,
      );
    }

    Widget _buildTitleAndInfo() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            testimony.title,
            style: kSFBodyBold,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                testimony.userName ?? ' ',
                style: kSFCaption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 7,
              ),
              _buildDate(),
            ],
          )
        ],
      );
    }

    Widget _buildDescription() {
      return Text(
        testimony.description,
        style: kSFBody,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget _buildLikeButton() {
      return TextButton(
        style: kTextButtonStyle,
        onPressed: onPressedLike,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite, color: kRed),
            const SizedBox(width: 7),
            Text(testimony.likes.toString(), style: kSFBody2)
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 230,
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
              _buildTitleAndInfo(),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: _buildDescription(),
              ),
              _buildLikeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
