import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onPressed;
  final VoidCallback onLongPressed;

  const EventCard({
    Key? key,
    required this.event,
    required this.onPressed,
    required this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      style: kTextButtonStyle,
      child: Stack(
        children: [
          Container(
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
              image: DecorationImage(
                image: NetworkImage(
                  event.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildGradient()
        ],
      ),
    );
  }

  Widget _buildGradient() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(kCardContentPadding),
      width: double.infinity,
      height: 230,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black26,
            Colors.black38,
            Colors.black45,
            Colors.black87,
            Colors.black,
          ],
        ),
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildLogoType(),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 5,
            child: _buildDate(),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoType() {
    IconData? icon = Icons.place_outlined;

    if (event.type == 'online') {
      icon = Icons.language_outlined;
    }

    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Icon(
        icon,
        color: kBlack,
        size: kIconSize,
      ),
    );
  }

  Widget _buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              FormalDates.formatEDmyyyy(date: event.startDate),
              style: kSFCaption.copyWith(color: Colors.white),
            ),
            const SizedBox(width: kContentSpacing12),
            Text(
              '${FormalDates.formatHm(date: event.startDate)} - ${FormalDates.formatHm(date: event.endDate)}',
              style: kSFCaption.copyWith(color: Colors.white),
            ),
          ],
        ),
        Text(
          event.title,
          style: kSFBody.copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
