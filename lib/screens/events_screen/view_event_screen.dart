import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ViewEventScreen extends StatefulWidget {
  final String eventType;
  final Event event;
  static String podcastDetailScreen = 'podcastDetailScreen';
  const ViewEventScreen({
    Key? key,
    required this.eventType,
    required this.event,
  }) : super(key: key);

  @override
  State<ViewEventScreen> createState() => _ViewEventScreenState();
}

class _ViewEventScreenState extends State<ViewEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kBodyPadding),
        child: Column(
          children: [
            _buildImage(),
            const SizedBox(height: 20),
            _buildTitle(),
            const SizedBox(height: 20),
            _buildEventInfo(),
            const SizedBox(height: 25),
            _buildDescription()
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
        style: kSFHeadLine3,
      ),
    );
  }

  Widget _buildDateTime() {
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
            size: 30,
          ),
        ),
        const SizedBox(width: kTextFieldSpacing),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FormalDates.formatEDmyyyy(date: widget.event.startDate),
              style: kSFBodyBold,
            ),
            Row(
              children: [
                Text(
                  '${FormalDates.formatHm(date: widget.event.startDate)} - ${FormalDates.formatHm(date: widget.event.endDate)}',
                  style: kSFBody2,
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Buttons.buildOutlinedButton(
          height: 26,
          width: 90,
          context: context,
          child: const Text('Calendar', style: kSFBtnStyle),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildEventLocation() {
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
            child: const Icon(Icons.language_outlined, size: 30),
          ),
          const SizedBox(width: kTextFieldSpacing),
          const Text('Zoom', style: kSFBodyBold),
          const Spacer(),
          Buttons.buildOutlinedButton(
            height: 26,
            width: 90,
            context: context,
            child: const Text('Join', style: kSFBtnStyle),
            onPressed: () {},
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
            size: 30,
          ),
        ),
        const SizedBox(width: kTextFieldSpacing),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                widget.event.location!['street'],
                style: kSFBodyBold,
              ),
            ),
            Flexible(
              child: Text(
                widget.event.location!['city'],
                style: kSFBody2,
              ),
            ),
          ],
        ),
        const Spacer(),
        Buttons.buildOutlinedButton(
          height: 26,
          width: 90,
          context: context,
          child: const Text('Maps', style: kSFBtnStyle),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildEventInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDateTime(),
        const SizedBox(height: 18),
        _buildEventLocation(),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        color: kBlack,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.event.image),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(kCardRadius),
        ),
        boxShadow: [
          kBoxShadow,
        ],
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
      leading: kBackButton(context: context),
    );
  }
}
