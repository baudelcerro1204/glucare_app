import 'package:flutter/material.dart';

class ActividadFisicaScreen extends StatefulWidget {
  const ActividadFisicaScreen({super.key});

  @override
  _ActividadFisicaScreenState createState() => _ActividadFisicaScreenState();
}

class _ActividadFisicaScreenState extends State<ActividadFisicaScreen> {
  String _selectedIntensity = 'Baja';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividad Física'),
        backgroundColor: Color(0xFFE3F2FD), // Color de fondo de la AppBar
      ),
      body: Container(
        color: Color(0xFFE3F2FD), // Fondo azul claro
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Elegir intensidad:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedIntensity,
                      items: <String>['Baja', 'Media', 'Alta']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedIntensity = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Sugerencias:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (_selectedIntensity == 'Baja') ...[
                ActivitySuggestionCard(activity: 'Yoga'),
                ActivitySuggestionCard(activity: 'Pilates'),
                ActivitySuggestionCard(activity: 'Ciclismo'),
                ActivitySuggestionCard(activity: 'Baile'),
              ] else if (_selectedIntensity == 'Media') ...[
                ActivitySuggestionCard(activity: 'Football'),
                ActivitySuggestionCard(activity: 'Handball'),
                ActivitySuggestionCard(activity: 'Basquetball'),
                ActivitySuggestionCard(activity: 'Tenis'),
              ] else if (_selectedIntensity == 'Alta') ...[
                ActivitySuggestionCard(activity: 'Natación'),
                ActivitySuggestionCard(activity: 'Boxeo'),
                ActivitySuggestionCard(activity: 'Cardio'),
                ActivitySuggestionCard(activity: 'Atletismo'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ActivitySuggestionCard extends StatelessWidget {
  final String activity;

  const ActivitySuggestionCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          activity,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
