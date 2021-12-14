import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestimonyCard extends StatelessWidget {
  final String title;
  final String testimony;
  final String timeAgo;
  final int likes;
  final VoidCallback? onPressedLike;
  final VoidCallback? onPressedCard;

  final Color? cardColor;
  final bool editable;

  const TestimonyCard({
    Key? key,
    required this.title,
    required this.testimony,
    required this.likes,
    required this.timeAgo,
    required this.editable,
    this.cardColor = kBlueLight,
    this.onPressedLike,
    this.onPressedCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressedCard,
      style: kTextButtonStyle,
      child: Container(
        width: double.infinity,
        height: 215,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: kSFCaption.copyWith(
                          color: kBlueDark,
                        ),
                      ),
                      _showEditIcon() // pas in note
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    timeAgo,
                    style: kSFSubtitle2.copyWith(
                      color: kBlueDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    testimony,
                    style: kSFBody.copyWith(color: kBlueDark),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: !editable
                    ? onPressedLike
                    : null, // disable the like button on edit
                style: kTextButtonStyle,
                child: SizedBox(
                  height: 23,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/icons/hand_clap_icon.png',
                        filterQuality: FilterQuality.high,
                        color: kBlueDark,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        likes.toString(),
                        style: kSFSubtitle2.copyWith(color: kBlueDark),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showEditIcon() {
    if (editable) {
      return const SizedBox(
        width: 30,
        child: Icon(
          FontAwesomeIcons.edit,
          size: 20,
          color: kBlueDark,
        ),
      );
    } else {
      return Container();
    }
  }
}
