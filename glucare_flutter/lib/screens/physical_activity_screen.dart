import 'package:flutter/material.dart';

class ActividadFisicaScreen extends StatefulWidget {
  const ActividadFisicaScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ActividadFisicaScreenState createState() => _ActividadFisicaScreenState();
}

class _ActividadFisicaScreenState extends State<ActividadFisicaScreen> {
  String _selectedIntensity = 'Baja';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividad Física'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedIntensity,
              items: <String>['Baja', 'Media', 'Alta']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedIntensity = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Selecciona la Intensidad',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedIntensity == 'Baja') ...[
              const Text('Ejercicios de Baja Intensidad'),
              // Aquí puedes agregar los ejercicios específicos
            ] else if (_selectedIntensity == 'Media') ...[
              const Text('Ejercicios de Media Intensidad'),
              // Aquí puedes agregar los ejercicios específicos
            ] else if (_selectedIntensity == 'Alta') ...[
              const Text('Ejercicios de Alta Intensidad'),
              // Aquí puedes agregar los ejercicios específicos
            ],
          ],
        ),
      ),
    );
  }
}
