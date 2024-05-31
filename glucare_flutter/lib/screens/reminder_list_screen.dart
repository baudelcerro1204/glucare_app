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
  final ApiService apiService = ApiService('http://192.168.0.5:8080');

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
        title: const Text('Recordatorios'),
      ),
      body: ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          final reminder = _reminders[index];
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
            ),
            title: Text(reminder.title),
            subtitle: Text(
              '${reminder.description}\n${reminder.date} ${reminder.time}\nEtiqueta: ${reminder.etiqueta}',
            ),
            onTap: () {
              _editReminder(context, reminder);
            },
          );
        },
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
            _addReminder(newReminder); // Agrega el nuevo recordatorio a la lista de recordatorios
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
