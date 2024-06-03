import 'package:flutter/material.dart';

class ActividadFisicaScreen extends StatefulWidget {
  const ActividadFisicaScreen({super.key});

  @override
  ActividadFisicaScreenState createState() => ActividadFisicaScreenState();
}

void main() {
  runApp(const MaterialApp(
    home: ActividadFisicaScreen(),
  ));
}

class ActividadFisicaScreenState extends State<ActividadFisicaScreen> {
  String _selectedIntensity = 'Baja';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividad Física'),
        backgroundColor: const Color(0xFFC0DEF4), // Color de fondo de la AppBar
        automaticallyImplyLeading: false, // Desactiva la flecha de retroceso
      ),
      body: Container(
        color: const Color(0xFFC0DEF4), // Fondo azul claro
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
                    boxShadow: const [
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                ActivitySuggestionCard(
                    activity: 'Yoga',
                    duration: '30 minutos',
                    info: 'Ideal para estiramientos y relajación.'),
                ActivitySuggestionCard(
                    activity: 'Pilates',
                    duration: '40 minutos',
                    info: 'Excelente para fortalecer el core.'),
                ActivitySuggestionCard(
                    activity: 'Ciclismo',
                    duration: '60 minutos',
                    info: 'Perfecto para mejorar la resistencia.'),
                ActivitySuggestionCard(
                    activity: 'Baile',
                    duration: '45 minutos',
                    info: 'Divertido y bueno para el cardio.'),
              ] else if (_selectedIntensity == 'Media') ...[
                ActivitySuggestionCard(
                    activity: 'Football',
                    duration: '90 minutos',
                    info: 'Gran ejercicio cardiovascular y de equipo.'),
                ActivitySuggestionCard(
                    activity: 'Handball',
                    duration: '60 minutos',
                    info: 'Bueno para la agilidad y resistencia.'),
                ActivitySuggestionCard(
                    activity: 'Basquetball',
                    duration: '60 minutos',
                    info: 'Excelente para el cardio y la coordinación.'),
                ActivitySuggestionCard(
                    activity: 'Tenis',
                    duration: '60 minutos',
                    info: 'Ideal para la velocidad y agilidad.'),
              ] else if (_selectedIntensity == 'Alta') ...[
                ActivitySuggestionCard(
                    activity: 'Natación',
                    duration: '60 minutos',
                    info: 'Perfecto para todo el cuerpo.'),
                ActivitySuggestionCard(
                    activity: 'Boxeo',
                    duration: '45 minutos',
                    info: 'Excelente para el cardio y la fuerza.'),
                ActivitySuggestionCard(
                    activity: 'Cardio',
                    duration: '30 minutos',
                    info: 'Ideal para quemar calorías rápidamente.'),
                ActivitySuggestionCard(
                    activity: 'Atletismo',
                    duration: '60 minutos',
                    info: 'Perfecto para mejorar la velocidad y resistencia.'),
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
  final String duration;
  final String info;

  const ActivitySuggestionCard({
    required this.activity,
    required this.duration,
    required this.info,
  });

  void _showActivityDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(activity),
          content: Text('Duración: $duration\n\n$info'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showActivityDetails(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
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
      ),
    );
  }
}
