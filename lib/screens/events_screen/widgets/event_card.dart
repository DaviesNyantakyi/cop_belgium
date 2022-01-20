import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String date;
  final String eventType;

  final VoidCallback onPressed;
  const EventCard({
    Key? key,
    required this.title,
    required this.date,
    required this.onPressed,
    required this.eventType,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  double avatarRadius = 12;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 130,
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
        onPressed: widget.onPressed,
        style: kTextButtonStyle,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildImage(),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildDetails(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 121,
      decoration: const BoxDecoration(
        color: kBlueDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://images.unsplash.com/photo-1443981257024-40c63080b3ed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1283&q=80',
          ),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const Flexible(child: SizedBox(height: 13)),
        _buildEventDetails(),
      ],
    );
  }

  Widget _buildEventDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCalendarDetails(
          icon: FontAwesomeIcons.calendar,
          date: '20 May 21',
          time: '8:30 AM',
        ),
        const SizedBox(height: 7),
        _buildLocationDetails()
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.title,
      style: kSFBodyBold,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCalendarDetails({
    required IconData icon,
    required String date,
    required String time,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: kBlueDark.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Icon(
            icon,
            color: kBlueDark,
            size: 20,
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: kSFCaption,
            ),
            Text(
              time,
              style: kSFCaption,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationDetails() {
    if (widget.eventType == 'online') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: kBlueDark.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Image.asset(
              'assets/images/logos/zoom.png',
              width: 22,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Zoom',
            style: kSFCaption,
          )
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: kBlueDark.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: const Icon(
            FontAwesomeIcons.mapMarkerAlt,
            color: kBlueDark,
            size: 20,
          ),
        ),
        const SizedBox(width: 6),
        const Flexible(
          child: Text(
            'Patriottenstraat 94, 2300 Turnhouttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt',
            style: kSFCaption,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
