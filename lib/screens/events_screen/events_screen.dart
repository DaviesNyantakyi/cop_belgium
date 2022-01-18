import 'package:cop_belgium/screens/events_screen/event_card.dart';
import 'package:cop_belgium/screens/events_screen/event_details_screen.dart';
import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    List<EventCard> list = [
      EventCard(
        title: 'Lorem ipsum dolor sit',
        date: '20 May 22',
        eventType: 'online',
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const EventDetailScreen(
                eventType: 'online',
              ),
            ),
          );
        },
      ),
      EventCard(
        title: 'Lorem ipsum dolor sit',
        date: '20 June 22',
        eventType: 'normal',
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const EventDetailScreen(
                eventType: 'normal',
              ),
            ),
          );
        },
      ),
      EventCard(
        title: 'Lorem ipsum dolor sit',
        date: '16 Aug 22',
        eventType: 'normal',
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const EventDetailScreen(
                eventType: 'normal',
              ),
            ),
          );
        },
      ),
      EventCard(
        title: 'Lorem ipsum dolor sit',
        date: '21 Apr 22',
        eventType: 'online',
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const EventDetailScreen(
                eventType: 'online',
              ),
            ),
          );
        },
      ),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCalendar(),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kBodyPadding, vertical: kBodyPadding),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, _) => const SizedBox(height: 10),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return list[index];
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week',
        CalendarFormat.month: 'Month',
      },
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      calendarStyle: CalendarStyle(
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        selectedDecoration: BoxDecoration(
          color: kBlueDark.withOpacity(0.4),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(
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
}
