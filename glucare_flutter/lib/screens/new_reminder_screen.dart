import 'package:flutter/material.dart';
import 'package:glucare/model/Reminder.dart';
import 'package:glucare/services/api_service.dart';
import 'package:intl/intl.dart';

class NewReminderScreen extends StatefulWidget {
  @override
  _NewReminderScreenState createState() => _NewReminderScreenState();
}

class _NewReminderScreenState extends State<NewReminderScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<bool> _repeatDays = List.filled(7, false);
  String _selectedTag = 'Mediciones de Azucar';
  Color _selectedColor = Colors.blue;

  final ApiService apiService = ApiService('http://192.168.0.136:8080');

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
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  void _saveReminder() async {
    final newReminder = Reminder(
      title: _titleController.text,
      description: _descriptionController.text,
      date: _selectedDate ?? DateTime.now(),
      time: _selectedTime ?? TimeOfDay.now(),
      repeatDays: _repeatDays,
      etiqueta: _selectedTag,
    );

    try {
      await apiService.saveReminder(newReminder);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recordatorio guardado con éxito')),
      );
      Navigator.pop(context, newReminder); // Retorna el nuevo recordatorio
    } catch (e) {
      print(e); // Asegúrate de imprimir la excepción
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar recordatorio: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nuevo Recordatorio'),
          backgroundColor: Color(0xFFC0DEF4),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: Color(0xFFC0DEF4), // Color de fondo
          child: SingleChildScrollView(
            child: Container(
              color: Color(
                  0xFFC0DEF4), // Color de fondo para cubrir toda la pantalla
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Título del recordatorio',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16.0),
                  Text('Fecha del recordatorio'),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      _selectedDate != null
                          ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                          : 'Seleccionar fecha',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Hora del recordatorio'),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text(
                      _selectedTime != null
                          ? _selectedTime!.format(context)
                          : 'Seleccionar hora',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
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
                        selectedColor: Colors.blue,
                        backgroundColor: Colors.white,
                        checkmarkColor: Colors.white,
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
                        _selectedColor = _tags.firstWhere(
                            (tag) => tag['label'] == value)['color'];
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveReminder,
                      child: Text('Guardar Recordatorio'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
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
