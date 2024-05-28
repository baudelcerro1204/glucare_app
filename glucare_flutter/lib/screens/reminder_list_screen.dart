import 'package:flutter/material.dart';
import 'package:glucare/screens/edit_reminder_screen.dart';
import 'package:glucare/screens/new_reminder_screen.dart';
import 'package:glucare/screens/reminder_screen.dart';

class ReminderListScreen extends StatefulWidget {
  const ReminderListScreen({Key? key}) : super(key: key);

  @override
  _ReminderListScreenState createState() => _ReminderListScreenState();
}

class _ReminderListScreenState extends State<ReminderListScreen> {
  List<Reminder> _reminders = [];

  void _addReminder(Reminder reminder) {
    setState(() {
      _reminders.add(reminder);
    });
  }

  void _viewReminderDetails(BuildContext context, Reminder reminder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(reminder.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Descripción: ${reminder.description}'),
              Text('Fecha: ${reminder.date.toString()}'),
              Text('Hora: ${reminder.time.format(context)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cerrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _editReminder(context, reminder);
              },
              child: Text('Editar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteReminder(reminder);
              },
              child: Text('Borrar'),
            ),
          ],
        );
      },
    );
  }

  void _editReminder(BuildContext context, Reminder reminder) async {
    final editedReminder = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReminderScreen(reminder: reminder),
      ),
    );
    if (editedReminder != null) {
      // Actualiza el recordatorio si se guardaron cambios
      setState(() {
        final index = _reminders.indexOf(reminder);
        _reminders[index] = editedReminder;
      });
    }
  }

  void _deleteReminder(Reminder reminder) {
    setState(() {
      _reminders.remove(reminder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      body: ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          final reminder = _reminders[index];
          return ListTile(
            title: Text(reminder.title),
            subtitle: Text('${reminder.description}\n${reminder.date} ${reminder.time.format(context)}'),
            onTap: () {
              _viewReminderDetails(context, reminder);
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
        child: Icon(Icons.add),
      ),
    );
  }
}
