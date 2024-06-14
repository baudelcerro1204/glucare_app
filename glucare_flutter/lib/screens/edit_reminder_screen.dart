import 'package:flutter/material.dart';
import 'package:glucare/model/Reminder.dart';
import 'package:glucare/services/api_service.dart';
import 'package:intl/intl.dart';

class EditReminderScreen extends StatefulWidget {
  final Reminder reminder;

  const EditReminderScreen({Key? key, required this.reminder})
      : super(key: key);

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

  late TextEditingController _otherTagController;

  final ApiService apiService = ApiService('http://192.168.0.5:8080');

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
    _descriptionController =
        TextEditingController(text: widget.reminder.description);
    _selectedDate = widget.reminder.date;
    _selectedTime = TimeOfDay(
        hour: widget.reminder.time.hour, minute: widget.reminder.time.minute);
    _repeatDays = List.from(widget.reminder.repeatDays);
    _selectedTag = widget.reminder.etiqueta!;
    _selectedColor =
        _tags.firstWhere((tag) => tag['label'] == _selectedTag)['color'];
    _otherTagController = TextEditingController();
  }

  void _updateReminder() async {
    final editedReminder = Reminder(
      id: widget.reminder.id,
      title: _titleController.text,
      description: _descriptionController.text,
      date: _selectedDate ?? DateTime.now(),
      time: _selectedTime ?? TimeOfDay.now(),
      repeatDays: _repeatDays,
      etiqueta:
          _selectedTag == 'Otro' ? _otherTagController.text : _selectedTag,
    );

    try {
      await apiService.updateReminder(editedReminder.id!, editedReminder);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recordatorio actualizado exitosamente')),
      );
      Navigator.pop(context, editedReminder);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar recordatorio: $e')),
      );
    }
  }

  void _confirmDeleteReminder() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text(
              '¿Estás seguro de que quieres eliminar este recordatorio?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancelar
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmar
              },
              child: const Text('Borrar'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      _deleteReminder();
    }
  }

  void _deleteReminder() async {
    try {
      await apiService.deleteReminder(widget.reminder.id!);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recordatorio eliminado exitosamente')),
      );
      Navigator.pop(context, widget.reminder);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar recordatorio: $e')),
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
          title: const Text('Editar Recordatorio'),
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
              color: Color(0xFFC0DEF4), // Color de fondo para cubrir toda la pantalla
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
                  if (_selectedTag == 'Otro') ...[
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _otherTagController,
                      decoration: InputDecoration(
                        labelText: 'Nombre de la etiqueta',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 32.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _updateReminder,
                      child: Text('Guardar Cambios'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: _confirmDeleteReminder,
                      child: Text('Borrar Recordatorio'),
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
