import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'day_details_screen.dart';
import 'package:glucare/services/api_service.dart';
import 'package:glucare/model/Reminder.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Reminder>> _reminders = {};
<<<<<<< HEAD
  final ApiService apiService = ApiService('http://192.168.0.15:8080');
=======
  final ApiService apiService = ApiService('http://192.168.0.136:8080');
>>>>>>> 7a7d503b81c4f48578ee4dc0ec72a5547957636b

  @override
  void initState() {
    super.initState();
    _inicializarConfiguracionLocal();
    _fetchReminders();
  }

  void _inicializarConfiguracionLocal() {
    initializeDateFormatting('es_ES', null);
  }

  Future<void> _fetchReminders() async {
    try {
      final reminders = await apiService.getReminders();
      setState(() {
        _reminders = _groupRemindersByDate(reminders);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener recordatorios: $e')),
      );
    }
  }

  Map<DateTime, List<Reminder>> _groupRemindersByDate(List<Reminder> reminders) {
    Map<DateTime, List<Reminder>> groupedReminders = {};
    for (var reminder in reminders) {
      final date = DateTime(reminder.date.year, reminder.date.month, reminder.date.day);
      if (groupedReminders[date] == null) {
        groupedReminders[date] = [];
      }
      groupedReminders[date]!.add(reminder);
    }
    return groupedReminders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        backgroundColor: const Color(0xFFC0DEF4),
        automaticallyImplyLeading: false, // Desactiva la flecha de retroceso
      ),
      body: Container(
        color: const Color(0xFFC0DEF4), // Color de fondo del cuerpo
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Fondo blanco solo para el calendario
                  borderRadius: BorderRadius.circular(12.0), // Bordes completamente redondeados
                ),
                child: TableCalendar(
                  locale: 'es_ES',
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DayDetailsScreen(date: selectedDay),
                      ),
                    );
                    if (result == true) {
                      _fetchReminders();
                    }
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: const Color(0xFF2A629A),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.blue[200],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    markersMaxCount: 1,
                    markerDecoration: const BoxDecoration(
                      color: Color(0xFF00D9FF),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                    headerMargin: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2A629A),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ), // Bordes redondeados solo en la parte superior
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                  ),
                  eventLoader: (day) {
                    final dayWithoutTime = DateTime(day.year, day.month, day.day);
                    final events = _reminders[dayWithoutTime] ?? [];
                    return events;
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (events.isNotEmpty) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00D9FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
              // Más contenido aquí si necesario, con el fondo del color original
            ],
          ),
        ),
      ),
    );
  }
}
