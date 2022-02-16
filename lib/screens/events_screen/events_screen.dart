import 'package:cop_belgium/models/event_model.dart';
import 'package:cop_belgium/screens/events_screen/create_event_screen.dart';
import 'package:cop_belgium/screens/events_screen/edit_event_screen.dart';
import 'package:cop_belgium/screens/events_screen/view_event_screen.dart';
import 'package:cop_belgium/screens/events_screen/widgets/event_card.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

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

  // String _chosenEventType = 'normal';

  List<Event> events = [
    Event(
      title: 'Revival Equipped to accomplish a great commission',
      startDate: DateTime(2022, 1, 26, 7),
      endDate: DateTime(2022, 1, 28, 21),
      type: 'online',
      description: 'National Proposed Officer Training Program Selection',
      image:
          'https://images.unsplash.com/photo-1614598632236-70bcd1c2f833?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      link:
          'https://zoom.us/j/96941681261?pwd=MmZhS1hpajFpN3E4Nldhd1RzRmdvUT09#success',
    ),
    Event(
      title: 'National Proposed Officer Training Program',
      startDate: DateTime(2022, 01, 08, 19),
      endDate: DateTime(2022, 01, 08, 19),
      location: {
        'street': 'Van der Keilenstraat',
        'podstcode': '2000',
        'city': 'Antwerp',
        'lat': '51.216896921177835',
        'long': '4.400080602355622'
      },
      type: 'normal',
      description: 'National Proposed Officer Training Program',
      image:
          'https://images.unsplash.com/photo-1643993574860-c1d7fe258ff3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80',
    ),
    Event(
      title: 'National Proposed Officer Training Program',
      startDate: DateTime(2022, 01, 08, 19),
      endDate: DateTime(2022, 01, 08, 19),
      location: {
        'street': 'Van der Keilenstraat',
        'podstcode': '2000',
        'city': 'Antwerp',
        'lat': '51.216896921177835',
        'long': '4.400080602355622'
      },
      type: 'normal',
      description: 'National Proposed Officer Training Program',
      image:
          'https://images.unsplash.com/photo-1643906652169-a750f3f70848?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
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
      appBar: AppBar(
        elevation: 1,
        title: const Text('Events', style: kSFHeadLine3),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_outlined),
        onPressed: () async {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) {
                return const CreateEventScreen();
              },
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCalendar(),
            const SizedBox(height: 35),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
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
                        builder: (context) => ViewEventScreen(
                          eventType: events[index].type,
                          event: events[index],
                        ),
                      ),
                    );
                  },
                  onLongPressed: () {
                    HapticFeedback.selectionClick();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => EditEventScreen(
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
        titleTextStyle: kSFHeadLine3,
        leftChevronMargin: const EdgeInsets.only(right: 10),
        rightChevronMargin: const EdgeInsets.only(left: 10),
        formatButtonTextStyle: kSFBtnStyleBold,
        leftChevronIcon: Icon(
          Icons.chevron_left_outlined,
          color: kBlack.withOpacity(0.7),
          size: 40,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right_outlined,
          color: kBlack.withOpacity(0.7),
          size: 40,
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
          color: kBlue.withOpacity(0.4),
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
          color: kBlue,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        outsideTextStyle: kSFBodyBold.copyWith(
          color: kBlack.withOpacity(0.3),
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
        _focusedDay = focusedDay;
      },
    );
  }
}
