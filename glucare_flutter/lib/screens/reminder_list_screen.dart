import 'package:flutter/material.dart';
import 'package:glucare/model/Reminder.dart';
import 'package:glucare/screens/edit_reminder_screen.dart';
import 'package:glucare/screens/new_reminder_screen.dart';
import 'package:glucare/services/api_service.dart';

class ReminderListScreen extends StatefulWidget {
  const ReminderListScreen({Key? key}) : super(key: key);

  @override
  _ReminderListScreenState createState() => _ReminderListScreenState();
}

class _ReminderListScreenState extends State<ReminderListScreen> {
  List<Reminder> _reminders = [];

  final ApiService apiService = ApiService('http://192.168.0.15:8080');


  @override
  void initState() {
    super.initState();
    _fetchReminders();
  }

  Future<void> _fetchReminders() async {
    try {
      final reminders = await apiService.getReminders();
      setState(() {
        _reminders = reminders;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener recordatorios: $e')),
      );
    }
  }

  void _addReminder(Reminder reminder) {
    setState(() {
      _reminders.add(reminder);
    });
  }

  void _editReminder(BuildContext context, Reminder reminder) async {
    final editedReminder = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReminderScreen(reminder: reminder),
      ),
    );
    if (editedReminder != null) {
      setState(() {
        final index = _reminders.indexWhere((r) => r.id == editedReminder.id);
        if (index != -1) {
          _reminders[index] = editedReminder;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFE3F2FD), // Color de fondo
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recordatorios',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  final reminder = _reminders[index];
                  var etiqueta = reminder.etiqueta;
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0), // Bordes más redondeados
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getTagColor(etiqueta!),
                      ),
                      title: Text(reminder.title),
                      subtitle: Text(
                        '${reminder.date}, ${reminder.time}\n${reminder.description}',
                      ),
                      onTap: () {
                        _editReminder(context, reminder);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newReminder = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewReminderScreen(),
            ),
          );
          if (newReminder != null) {
            _addReminder(newReminder);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag) {
      case 'Mediciones de Azucar':
        return Colors.blue;
      case 'Dosis de Insulina':
        return Colors.green;
      case 'Comidas':
        return Colors.red;
      case 'Medicamentos':
        return Colors.orange;
      case 'Citas con medicos':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
