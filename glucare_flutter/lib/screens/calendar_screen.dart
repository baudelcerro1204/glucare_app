import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importa esto para localización
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
  void initState() {
    super.initState();
    _inicializarConfiguracionLocal();
  }

  void _inicializarConfiguracionLocal() {
    // Inicializa la configuración local para español
    initializeDateFormatting('es_ES', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        backgroundColor: Color(0xFFC0DEF4),
        automaticallyImplyLeading: false, // Desactiva la flecha de retroceso
      ),
      body: Container(
        color: Color(0xFFC0DEF4), // Color de fondo del cuerpo
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Fondo blanco solo para el calendario
                  borderRadius: BorderRadius.circular(
                      12.0), // Bordes completamente redondeados
                ),
                child: TableCalendar(
                  locale: 'es_ES',
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
                        builder: (context) =>
                            DayDetailsScreen(date: selectedDay),
                      ),
                    );
                  },
                  calendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFF2A629A),
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
                    markerDecoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.white),
                    headerMargin: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2A629A),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ), // Bordes redondeados solo en la parte superior
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
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
