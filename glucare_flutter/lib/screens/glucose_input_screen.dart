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
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Fecha: ${widget.date.toLocal().toShortString()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nivel de Glucosa',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _glucoseLevel = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Hora: ${_selectedTime.format(context)}',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: _selectTime,
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _registerGlucoseLevel,
                child: Text('Registrar Nivel de Glucosa'),
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
