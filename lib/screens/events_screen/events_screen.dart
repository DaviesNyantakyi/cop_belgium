import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/screens/events_screen/create_event_screen.dart';
import 'package:cop_belgium/screens/events_screen/event_details_screen.dart';
import 'package:cop_belgium/screens/events_screen/widgets/event_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

enum EventType { normal, online }

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

  List<Event> events = [
    Event(
      title: 'S04 E37 - Season 4 Finale Episode: Make Room',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(
        const Duration(hours: 3),
      ),
      type: 'online',
      description:
          'As we wrap up 2021 & Season 4, it’s time to evaluate What’s taking up space and Make ROOM for your healing, your goals and all that God has for you. In this episode I share some personal revelations on my healing journey from this year, from acknowledging the hard t',
      image:
          'https://images.unsplash.com/photo-1642793891075-4f53583a2079?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
      zoomLink:
          'https://zoom.us/j/96941681261?pwd=MmZhS1hpajFpN3E4Nldhd1RzRmdvUT09#success',
    ),
    Event(
      title: 'S04 E37 - Season 4 Finale Episode: Make Room',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(
        const Duration(hours: 3),
      ),
      location: {
        'street': 'Middelolenlaan 123',
        'podstcode': '2100',
        'city': 'Deurne',
        'lat': '51.31830821507976',
        'long': '4.939745926843822'
      },
      type: 'normal',
      description:
          'As we wrap up 2021 & Season 4, it’s time to evaluate What’s taking up space and Make ROOM for your healing, your goals and all that God has for you. In this episode I share some personal revelations on my healing journey from this year, from acknowledging the hard t',
      image:
          'https://images.unsplash.com/photo-1642793891075-4f53583a2079?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
      zoomLink:
          'https://zoom.us/j/96941681261?pwd=MmZhS1hpajFpN3E4Nldhd1RzRmdvUT09#success',
    ),
  ];
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
            ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: kBodyPadding),
              separatorBuilder: (context, _) => const SizedBox(
                height: kCardSpacing,
              ),
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventCard(
                  event: events[index],
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => EventDetailScreen(
                          eventType: events[index].type,
                          event: events[index],
                        ),
                      ),
                    );
                  },
                );
              },
            )
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
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: kSFCaption,
        weekendStyle: kSFCaption,
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: kSFHeadLine2,
        leftChevronMargin: const EdgeInsets.only(left: 2, right: 10),
        rightChevronMargin: const EdgeInsets.only(right: 2, left: 10),
        formatButtonTextStyle: kSFBtnStyleBold,
        leftChevronIcon: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: kBlueDark,
        ),
        rightChevronIcon: const Icon(
          FontAwesomeIcons.chevronRight,
          color: kBlueDark,
        ),
        formatButtonDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(),
        ),
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle: kSFBody,
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
        outsideTextStyle: kSFBodyBold.copyWith(
          color: kBlueDark.withOpacity(0.3),
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
            const contentPadding = EdgeInsets.all(0);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<EventType>(
                  contentPadding: contentPadding,
                  activeColor: kBlueDark,
                  value: EventType.normal,
                  groupValue: _eventType,
                  title: const Text('Normal', style: kSFBody),
                  onChanged: (value) {
                    _eventType = value!;
                    setState(() {});
                  },
                ),
                RadioListTile<EventType>(
                  contentPadding: contentPadding,
                  activeColor: kBlueDark,
                  value: EventType.online,
                  groupValue: _eventType,
                  title: const Text('Online', style: kSFBody),
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
            child: const Text(
              'Cancel',
              style: kSFBody2Bold,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return CreateEventScreen(
                      eventType: _eventType,
                      editable: false,
                    );
                  },
                ),
              );
            },
            child: const Text('OK', style: kSFBodyBold),
          ),
        ],
      ),
    );
  }
}
