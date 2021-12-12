import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

class TestimonyCard extends StatelessWidget {
  final String title;
  final String testimony;
  final String timeAgo;
  final int likes;
  final VoidCallback? onTapLike;
  final VoidCallback? onTapCard;
  final Color? cardColor;
  final Color? textColor;
  final bool editable;

  const TestimonyCard({
    Key? key,
    required this.title,
    required this.testimony,
    required this.likes,
    required this.timeAgo,
    required this.editable,
    this.cardColor = kBlueLight,
    this.onTapLike,
    this.onTapCard,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _showEditIcon() {
      if (editable) {
        return Image.asset(
          'assets/images/icons/edit_icon.png',
          color: textColor,
        );
      } else {
        return Container();
      }
    }

    return InkWell(
      onTap: onTapCard,
      child: Container(
        width: double.infinity,
        height: 213,
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
                          color: textColor,
                        ),
                      ),
                      _showEditIcon()
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    timeAgo,
                    style: kSFSubtitle2.copyWith(
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    testimony,
                    style: kSFBody.copyWith(color: textColor),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: onTapLike,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/icons/hand_clap_icon.png',
                          filterQuality: FilterQuality.high,
                          color: textColor,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          likes.toString(),
                          style: kSFSubtitle2.copyWith(color: textColor),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
