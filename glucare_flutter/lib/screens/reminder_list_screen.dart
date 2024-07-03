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
      appBar: AppBar(
        automaticallyImplyLeading: false, // Elimina la flecha de regreso
        title: const Text('Recordatorios'), // Establece Recordatorios como título
        backgroundColor: const Color(0xFFC0DEF4),
      ),
      body: Container(
        color: Color(0xFFC0DEF4), // Color de fondo
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  final reminder = _reminders[index];
                  var etiqueta = reminder.etiqueta;
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(16.0), // Bordes más redondeados
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 10, // Tamaño ajustado del punto de color
                        backgroundColor: _getTagColor(etiqueta!),
                      ),
                      title: Text(reminder.title),
                      subtitle: Text(
                        '${reminder.date.toLocal().toString().split(' ')[0]}, ${reminder.time.format(context)}\n${reminder.description}',
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
        backgroundColor: const Color(0xFF2A629A),
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
