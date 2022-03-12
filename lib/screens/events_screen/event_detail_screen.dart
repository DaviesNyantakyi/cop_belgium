import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/screens/events_screen/edit_event_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/enum_to_string.dart';
import 'package:cop_belgium/utilities/formal_date_format.dart';
import 'package:cop_belgium/widgets/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _cardSize = 59.0;
enum EventType { normal, online }

class EventDetailScreen extends StatefulWidget {
  final Event event;
  const EventDetailScreen({
    Key? key,
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
            Padding(
              padding: const EdgeInsets.all(kBodyPadding),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildEventInfo(),
                  const SizedBox(height: 25),
                  _buildDescription()
                ],
              ),
            ),
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
          width: _cardSize,
          height: _cardSize,
          decoration: BoxDecoration(
            color: kBlack.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: TextButton(
            style: kTextButtonStyle,
            child: const Icon(
              Icons.calendar_today_outlined,
              color: kBlack,
              size: 30,
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: kContentSpacing12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FormalDates.formatEDmyyyyHm(date: widget.event.startDate),
              style: kSFBody,
            ),
            Text(
              FormalDates.formatEDmyyyyHm(date: widget.event.endDate),
              style: kSFBody,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEventLocation() {
    if (widget.event.type == enumToString(object: EventType.online)) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _cardSize,
            height: _cardSize,
            decoration: BoxDecoration(
              color: kBlack.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: TextButton(
              style: kTextButtonStyle,
              child: const Icon(
                Icons.language_outlined,
                size: 30,
                color: kBlack,
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: kContentSpacing12),
          const Text('Online', style: kSFBody),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: _cardSize,
          height: _cardSize,
          decoration: BoxDecoration(
            color: kBlack.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: TextButton(
            style: kTextButtonStyle,
            child: const Icon(
              Icons.location_on_outlined,
              color: kBlack,
              size: 30,
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: kContentSpacing12),
        Expanded(
          child: Text(
            widget.event.address ?? ' ',
            style: kSFBody,
          ),
        ),
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
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
        color: kBlack,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.event.image),
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
      leading: kBackButton(context: context),
      actions: [
        _buildDeleteButton(),
        _buildEditButton(),
      ],
    );
  }

  Widget _buildEditButton() {
    return TextButton(
      child: const Text('EDIT', style: kSFBody),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditEventScreen(event: widget.event),
          ),
        );
      },
    );
  }

  Widget _buildDeleteButton() {
    return TextButton(
      child: Text('DELETE', style: kSFBody.copyWith(color: kRed)),
      onPressed: () {
        _showDeleteDialog();
      },
    );
  }

  Future<String?> _showDeleteDialog() {
    return showMyDialog(
      context: context,
      title: const Text('Delete this Event?', style: kSFHeadLine3),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: kSFBody,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Delete',
            style: kSFBody.copyWith(color: kRed),
          ),
        )
      ],
    );
  }
}
