import 'package:cop_belgium/models/event.dart';
import 'package:cop_belgium/screens/events_screen/create_event_screen.dart';
import 'package:cop_belgium/screens/events_screen/widgets/event_card.dart';
import 'package:cop_belgium/screens/events_screen/event_details_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

enum EventType { normal, zoom }

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>>? _selectedEvents;

  EventType _eventType = EventType.normal;

  @override
  void initState() {
    _selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventFromDay(DateTime day) {
    return _selectedEvents?[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(FontAwesomeIcons.plus),
        onPressed: () async {
          _showEventDialog();
          // await showDialog<void>(
          //   context: context,
          //   builder: (BuildContext context) {
          //     int? selectedRadio = 0;
          //     return AlertDialog(
          //       content: StatefulBuilder(
          //         builder: (BuildContext context, StateSetter setState) {
          //           return Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: List<Widget>.generate(4, (int index) {
          //               return Radio<int>(
          //                 value: index,
          //                 groupValue: selectedRadio,
          //                 onChanged: (int? value) {
          //                   setState(() => selectedRadio = value);
          //                 },
          //               );
          //             }),
          //           );
          //         },
          //       ),
          //     );
          //   },
          // );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCalendar(),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(1999, 1, 01),
      lastDay: DateTime.utc(2030, 12, 31),
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week',
        CalendarFormat.month: 'Month',
      },
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      headerStyle: HeaderStyle(
        formatButtonDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(),
        ),
      ),
      calendarStyle: CalendarStyle(
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        weekendDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        selectedDecoration: BoxDecoration(
          color: kBlueDark.withOpacity(0.4),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        outsideDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        todayDecoration: const BoxDecoration(
          color: kBlueDark,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      eventLoader: (DateTime selectedDay) {
        return _getEventFromDay(selectedDay);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }

  Future<String?> _showEventDialog() async {
    return await showDialog<String?>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kButtonRadius),
          ),
        ),
        title: const Text(
          'Create event',
          style: kSFBodyBold,
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<EventType>(
                  value: EventType.normal,
                  groupValue: _eventType,
                  title: const Text('Normal', style: kSFBody),
                  onChanged: (value) {
                    _eventType = value!;
                    setState(() {});
                  },
                ),
                RadioListTile<EventType>(
                  value: EventType.zoom,
                  groupValue: _eventType,
                  title: const Text('Zoom', style: kSFBody),
                  onChanged: (value) {
                    _eventType = value!;
                    setState(() {});
                  },
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: const Text('Cancel', style: kSFCaptionBold),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return CreateEventScreen(
                      eventType: _eventType,
                    );
                  },
                ),
              );
            },
            child: const Text('Continue', style: kSFCaptionBold),
          ),
        ],
      ),
    );
  }
}
