import 'package:cop_belgium/utilities/constant.dart';
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
        const SizedBox(height: 10),
        _buildAttendence(),
      ],
    );
  }

  Widget _buildEventDetails() {
    return Row(
      children: [
        _buildCalendarDetails(
          icon: FontAwesomeIcons.calendar,
          date: '20 May 21',
          time: '8:30 AM',
        ),
        const SizedBox(width: 10),
        _buildLocationDetails()
      ],
    );
  }

  Widget _buildAttendence() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 65),
          alignment: Alignment.centerLeft,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                  ),
                ),
              ),
              Positioned(
                left: 14,
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
                  ),
                ),
              ),
              Positioned(
                left: 28,
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                  ),
                ),
              ),
              Positioned(
                left: 42,
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                  ),
                ),
              ),
              Positioned(
                left: 56,
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
                  ),
                ),
              ),
            ],
          ),
        ),
        const Text(
          '+ 120 Going',
          style: kSFCaption,
        ),
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
              style: kSFUnderline,
            ),
            Text(
              time,
              style: kSFUnderline,
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
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logos/zoom.png',
                  width: 20,
                ),
                const SizedBox(width: 6),
                const Text(
                  'Zoom',
                  style: kSFCaptionBold,
                ),
              ],
            ),
          ),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Turnhout',
              style: kSFUnderlineBold,
            ),
            Flexible(
              child: Text(
                'Korte',
                style: kSFUnderline,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
