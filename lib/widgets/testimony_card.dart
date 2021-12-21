import 'package:cop_belgium/models/testimony_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestimonyCard extends StatelessWidget {
  final VoidCallback? onPressedLike;
  final VoidCallback? onPressedCard;
  final VoidCallback? onPressedEdit;
  final TestimonyInfo testimonyInfo;

  //show the edit icon
  final bool? editable;

  const TestimonyCard({
    Key? key,
    this.editable = false,
    this.onPressedLike,
    this.onPressedCard,
    this.onPressedEdit,
    required this.testimonyInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 185,
      decoration: BoxDecoration(
        color: Color(int.parse(testimonyInfo.cardColor.toString())),
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
              _buildName(),
              const SizedBox(height: 8),
              Text(
                FormalDates.formatDm(date: testimonyInfo.date),
                style: kSFSubtitle2.copyWith(
                  color: kBlueDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                testimonyInfo.testimony.toString(),
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

  Widget _buildName() {
    if (testimonyInfo.anonymous == false) {
      return Text(
        'by ${testimonyInfo.userName}',
        style: kSFSubtitle2.copyWith(
          color: kBlueDark,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildLikeButton() {
    return Flexible(
      child: TextButton(
        onPressed: onPressedLike,
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
                testimonyInfo.likes.toString(),
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
      children: [
        Expanded(
          flex: 8,
          child: Text(
            testimonyInfo.title.toString(),
            style: kSFCaptionBold.copyWith(
              color: kBlueDark,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(width: 10),
        ),
        Expanded(
          flex: 1,
          child: _showEditIcon(),
        )
      ],
    );
  }

  Widget _showEditIcon() {
    if (editable == true) {
      return SizedBox(
        width: 30,
        height: 40,
        child: TextButton(
          style: kTextButtonStyle,
          child: const Icon(
            FontAwesomeIcons.edit,
            size: 20,
            color: kBlueDark,
          ),
          onPressed: onPressedEdit,
        ),
      );
    } else {
      return Container();
    }
  }
}
