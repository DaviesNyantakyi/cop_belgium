import 'package:cop_belgium/utilities/constant.dart';
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

  //show the edit icon
  final bool? editable;

  const TestimonyCard({
    Key? key,
    required this.title,
    required this.testimony,
    required this.likes,
    required this.timeAgo,
    this.editable = false,
    this.cardColor,
    this.onPressedLike,
    this.onPressedCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextButton(
        onPressed: onPressedCard,
        style: kTextButtonStyle,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTitleIcon(),
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              _buildLikeButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLikeButton() {
    return Flexible(
      child: TextButton(
        onPressed: editable == false
            ? onPressedLike
            : null, // disable  like button when card is editable
        style: kTextButtonStyle,
        child: SizedBox(
          height: 25,
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
      ),
    );
  }

  Widget _buildTitleIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kSFCaptionBold.copyWith(
            color: kBlueDark,
          ),
        ),
        _showEditIcon()
      ],
    );
  }

  Widget _showEditIcon() {
    if (editable == true) {
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
