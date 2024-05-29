import 'package:flutter/material.dart';
import 'package:glucare/screens/reminder_screen.dart';
import 'package:intl/intl.dart';

class EditReminderScreen extends StatefulWidget {
  final Reminder reminder;

  const EditReminderScreen({Key? key, required this.reminder}) : super(key: key);

  @override
  _EditReminderScreenState createState() => _EditReminderScreenState();
}

class _EditReminderScreenState extends State<EditReminderScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<bool> _repeatDays = [];
  String _selectedTag = '';
  Color _selectedColor = Colors.blue;

  final List<Map<String, dynamic>> _tags = [
    {'label': 'Mediciones de Azucar', 'color': Colors.blue},
    {'label': 'Dosis de Insulina', 'color': Colors.green},
    {'label': 'Comidas', 'color': Colors.red},
    {'label': 'Medicamentos', 'color': Colors.orange},
    {'label': 'Citas con medicos', 'color': Colors.purple},
    {'label': 'Otro', 'color': Colors.grey},
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.reminder.title);
    _descriptionController = TextEditingController(text: widget.reminder.description);
    _selectedDate = widget.reminder.date;
    _selectedTime = widget.reminder.time;
    _repeatDays = List.from(widget.reminder.repeatDays);
    _selectedTag = widget.reminder.etiqueta;
    _selectedColor = _tags.firstWhere((tag) => tag['label'] == _selectedTag)['color'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Recordatorio'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título del recordatorio'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            Text('Fecha del recordatorio'),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(_selectedDate != null ? DateFormat('dd/MM/yyyy').format(_selectedDate!) : 'Seleccionar fecha'),
            ),
            SizedBox(height: 16.0),
            Text('Hora del recordatorio'),
            TextButton(
              onPressed: () => _selectTime(context),
              child: Text(_selectedTime != null ? _selectedTime!.format(context) : 'Seleccionar hora'),
            ),
            SizedBox(height: 16.0),
            Text('Días de repetición'),
            Wrap(
              spacing: 8.0,
              children: List.generate(7, (index) {
                return FilterChip(
                  label: Text(_getDayName(index)),
                  selected: _repeatDays[index],
                  onSelected: (selected) {
                    setState(() {
                      _repeatDays[index] = selected;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 16.0),
            Text('Etiqueta del recordatorio'),
            DropdownButtonFormField<String>(
              value: _selectedTag,
              items: _tags.map((tag) {
                return DropdownMenuItem<String>(
                  value: tag['label'],
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: tag['color'],
                      ),
                      SizedBox(width: 8),
                      Text(tag['label']),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTag = value!;
                  _selectedColor = _tags.firstWhere((tag) => tag['label'] == value)['color'];
                });
              },
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                final editedReminder = Reminder(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: _selectedDate ?? DateTime.now(),
                  time: _selectedTime ?? TimeOfDay.now(),
                  repeatDays: _repeatDays,
                  etiqueta: _selectedTag,
                  color: _selectedColor,
                );
                Navigator.pop(context, editedReminder);
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String _getDayName(int index) {
    switch (index) {
      case 0:
        return 'Lun';
      case 1:
        return 'Mar';
      case 2:
        return 'Mié';
      case 3:
        return 'Jue';
      case 4:
        return 'Vie';
      case 5:
        return 'Sáb';
      case 6:
        return 'Dom';
      default:
        return '';
    }
  }
}
