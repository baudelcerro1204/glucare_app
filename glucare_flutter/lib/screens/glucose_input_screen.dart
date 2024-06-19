import 'package:flutter/material.dart';
import 'package:glucare/model/GlucoseMeasurement.dart';
import 'package:glucare/services/api_service.dart';

class GlucoseInputScreen extends StatefulWidget {
  final DateTime date;

  const GlucoseInputScreen({Key? key, required this.date}) : super(key: key);

  @override
  _GlucoseInputScreenState createState() => _GlucoseInputScreenState();
}

class _GlucoseInputScreenState extends State<GlucoseInputScreen> {
  String _glucoseLevel = '';
  TimeOfDay _selectedTime = TimeOfDay.now();

  final ApiService apiService = ApiService('http://192.168.0.15:8080');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Nivel de Glucosa'),
        backgroundColor: Color(0xFFC0DEF4), // Fondo color celeste en la AppBar
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Color(0xFFC0DEF4), // Fondo color celeste
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Color(0xFF2A629A), // Fondo azul marino
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
              ),
              child: Text(
                'Fecha: ${widget.date.toLocal().toShortString()}',
                style: TextStyle(fontSize: 16, color: Color(0xFF00D9FF)), // Color celeste flúor
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Nivel de Glucosa',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _glucoseLevel = value;
                });
              },
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Color(0xFF2A629A), // Fondo azul marino
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hora: ${_selectedTime.format(context)}',
                    style: TextStyle(fontSize: 16, color: Color(0xFF00D9FF)), // Color celeste flúor
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time, color: Color(0xFF00D9FF)), // Icono color celeste flúor
                    onPressed: _selectTime,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _registerGlucoseLevel,
                child: Text(
                  'Registrar Nivel de Glucosa',
                  style: TextStyle(color: Color(0xFF00D9FF)), // Color celeste flúor para el texto
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2A629A), // Color azul marino para el botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordes redondeados
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _registerGlucoseLevel() async {
    try {
      if (_glucoseLevel.isEmpty) {
        throw Exception('Por favor ingrese el nivel de glucosa');
      }

      // Parsea el nivel de glucosa a double
      final double glucoseValue = double.parse(_glucoseLevel);

      // Crea el objeto GlucoseMeasurement
      final glucoseMeasurement = GlucoseMeasurement(
        value: glucoseValue,
        date: widget.date,
        time: _selectedTime,
      );

      // Guarda la medición de glucosa usando ApiService
      await apiService.saveGlucoseMeasurement(glucoseMeasurement);

      // Navega de regreso a la pantalla anterior
      Navigator.pop(context, true);
    } catch (e) {
      print('Error al registrar nivel de glucosa: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar nivel de glucosa: $e')),
      );
    }
  }
}

extension DateTimeExtension on DateTime {
  String toShortString() {
    return '${this.year}-${this.month.toString().padLeft(2, '0')}-${this.day.toString().padLeft(2, '0')}';
  }
}
