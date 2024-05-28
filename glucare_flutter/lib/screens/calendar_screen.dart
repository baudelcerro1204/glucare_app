import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'day_details_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        backgroundColor: Color(0xFFE3F2FD),
      ),
      body: Container(
        color: Color(0xFFE3F2FD),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayDetailsScreen(date: selectedDay),
                ),
              );
            },
            calendarFormat: CalendarFormat.month,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue[200],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
