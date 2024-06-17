import 'package:flutter/material.dart';
import 'package:glucare/model/Reminder.dart';
import 'package:glucare/model/GlucoseMeasurement.dart';
import 'package:glucare/screens/glucose_input_screen.dart';
import 'package:glucare/services/api_service.dart';

class DayDetailsScreen extends StatefulWidget {
  final DateTime date;

  const DayDetailsScreen({Key? key, required this.date}) : super(key: key);

  @override
  _DayDetailsScreenState createState() => _DayDetailsScreenState();
}

class _DayDetailsScreenState extends State<DayDetailsScreen> {
  bool _hadHypoHyper = false;
  String _physicalActivity = '';
  String _foodIntake = '';
  String _notes = '';
  List<Reminder> _reminders = [];
  List<GlucoseMeasurement> _glucoseMeasurements = [];
  final ApiService apiService = ApiService('http://192.168.0.136:8080');

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _fetchReminders();
    await _fetchGlucoseMeasurements();
  }

  Future<void> _fetchReminders() async {
    try {
      final reminders = await apiService.getRemindersByDate(widget.date);
      setState(() {
        _reminders = reminders;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener recordatorios: $e')),
      );
    }
  }

  Future<void> _fetchGlucoseMeasurements() async {
    try {
      final glucoseMeasurements = await apiService.getGlucoseMeasurementsByDate(widget.date);
      setState(() {
        _glucoseMeasurements = glucoseMeasurements;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener mediciones de glucosa: $e')),
      );
    }
  }

  Future<void> _saveReminder(Reminder reminder) async {
    try {
      await apiService.saveReminder(reminder);
      setState(() {
        _reminders.add(reminder);
      });
      Navigator.pop(context, true); // Regresar y actualizar calendario
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar recordatorio: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFC0DEF4),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context, false); // Regresar sin actualizar calendario
                        },
                      ),
                      Text(
                        '${widget.date.day}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 48), // Espacio para equilibrar el diseño
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Episodios de hipoglucemia o hiperglucemia:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _hadHypoHyper = true;
                          });
                        },
                        child: Text('SI'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _hadHypoHyper ? Colors.blue : Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _hadHypoHyper = false;
                          });
                        },
                        child: Text('NO'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !_hadHypoHyper ? Colors.blue : Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildDetailCard(
                    'Actividad física realizada',
                    Icons.fitness_center,
                    (value) {
                      setState(() {
                        _physicalActivity = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _buildDetailCard(
                    'Alimentos ingeridos',
                    Icons.restaurant,
                    (value) {
                      setState(() {
                        _foodIntake = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _buildDetailCard(
                    'Notas',
                    Icons.note,
                    (value) {
                      setState(() {
                        _notes = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  if (_reminders.isNotEmpty) ...[
                    Text(
                      'Recordatorios:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ..._reminders.map((reminder) => _buildReminderCard(reminder)).toList(),
                    SizedBox(height: 20),
                  ],
                  if (_glucoseMeasurements.isNotEmpty) ...[
                    Text(
                      'Mediciones de Glucosa:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ..._glucoseMeasurements.map((measurement) => _buildGlucoseMeasurementCard(measurement)).toList(),
                    SizedBox(height: 20),
                  ],
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final newReminder = Reminder(
                          title: 'Nuevo recordatorio',
                          description: 'Descripción del recordatorio',
                          date: widget.date,
                          time: TimeOfDay.now(),
                          repeatDays: [false, false, false, false, false, false, false],
                          etiqueta: 'General',
                        );
                        _saveReminder(newReminder);
                      },
                      child: const Text('Guardar'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GlucoseInputScreen(date: widget.date),
                          ),
                        );
                      },
                      child: const Text('Registrar nivel de glucosa'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, IconData icon, Function(String) onChanged) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: label,
                  border: InputBorder.none,
                ),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard(Reminder reminder) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${reminder.date.toLocal()}, ${reminder.time.format(context)}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              reminder.description,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlucoseMeasurementCard(GlucoseMeasurement measurement) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha: ${measurement.date.toLocal()}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Hora: ${measurement.time.format(context)}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Nivel de Glucosa: ${measurement.value}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String toShortString() {
    return '${this.year}-${this.month.toString().padLeft(2, '0')}-${this.day.toString().padLeft(2, '0')}';
  }
}
