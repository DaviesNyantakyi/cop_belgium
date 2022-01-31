import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:flutter/material.dart';

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
            color: kBlack.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: const Icon(
            Icons.calendar_today_outlined,
            color: kBlack,
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
              color: kBlack.withOpacity(0.1),
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
            color: kBlack.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: const Icon(
            Icons.location_on_outlined,
            color: kBlack,
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
      decoration: BoxDecoration(
        color: kBlack,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(widget.event.image),
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
            widget.event.description,
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
          Icons.more_vert,
          color: kBlack,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        style: kTextButtonStyle,
      ),
    );
  }
}
