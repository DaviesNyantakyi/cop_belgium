import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final VoidCallback onPressed;

  const EventCard({
    Key? key,
    required this.event,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  double avatarRadius = 12;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
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
                  widget.event.image,
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

    if (widget.event.type == 'online') {
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
              FormalDates.formatEDmy(date: widget.event.startDate),
              style: kSFCaption.copyWith(color: Colors.white),
            ),
            Text(' - ', style: kSFCaption.copyWith(color: Colors.white)),
            Text(
              '${FormalDates.formatHm(date: widget.event.startDate)} - ${FormalDates.formatHm(date: widget.event.endDate)}',
              style: kSFCaption.copyWith(color: Colors.white),
            ),
          ],
        ),
        Text(
          widget.event.title,
          style: kSFBody.copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
