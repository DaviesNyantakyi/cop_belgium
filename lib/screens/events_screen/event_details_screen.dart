import 'package:cop_belgium/models/episodes_model.dart';
import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/bottomsheet.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String _description =
    'Laborum ut non adipisicing labore eiusmod enim ex fugiat Lorem esse ea do. Pariatur officia nisi nulla enim non nostrud minim cillum voluptate ex mollit. Elit dolor non adipisicing nulla in elit ipsum magna labore ea aliqua minim. Amet excepteur ullamco aliqua reprehenderit in sint. Minim excepteur commodo anim incididunt officia anim nisi id Lorem excepteur et in quis ea.';

String _title = 'Laborum ut non adipisicing labore eiusmod enim ex ';

class EventDetailScreen extends StatefulWidget {
  final String eventType;
  final Event event;
  static String podcastDetailScreen = 'podcastDetailScreen';
  const EventDetailScreen({
    Key? key,
    required this.eventType,
    required this.event,
  }) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImage(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(kBodyPadding),
              child: Column(
                children: [
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildEventInfo(),
                  const SizedBox(height: 25),
                  _buildDescription(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.event.title,
        style: kSFHeadLine2,
      ),
    );
  }

  Widget _buildCalendarInfo() {
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
            FontAwesomeIcons.calendar,
            color: kBlueDark,
            size: 24,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FormalDates.formatEDmy(date: widget.event.startDate),
                style: kSFBodyBold,
              ),
              Row(
                children: [
                  Text(
                    '${FormalDates.formatHm(date: widget.event.startDate)} - ${FormalDates.formatHm(date: widget.event.endDate)}',
                    style: kSFCaption,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo() {
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
              width: 24,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Zoom',
            style: kSFBody,
          )
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
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
          children: [
            Flexible(
              child: Text(
                widget.event.location!['street'],
                style: kSFBody,
              ),
            ),
            Flexible(
              child: Text(
                widget.event.location!['city'],
                style: kSFCaption,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEventInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCalendarInfo(),
        const SizedBox(height: 18),
        _buildLocationInfo(),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
        color: kBlueDark,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://images.unsplash.com/photo-1620982591827-5e003e8d26fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'About Event',
            style: kSFBodyBold,
          ),
        ),
        const SizedBox(height: 7),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            _description,
            style: kSFBody,
          ),
        ),
      ],
    );
  }

  dynamic _buildAppbar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: TextButton(
        child: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: kBlueDark,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }
}
