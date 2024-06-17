import 'package:flutter/material.dart';
import 'package:glucare/model/PhysicalActivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:glucare/services/api_service.dart'; // Importa tu ApiService

class ActividadFisicaScreen extends StatefulWidget {
  final DateTime date;

  const ActividadFisicaScreen({Key? key, required this.date}) : super(key: key);

  @override
  ActividadFisicaScreenState createState() => ActividadFisicaScreenState();
}

class ActividadFisicaScreenState extends State<ActividadFisicaScreen> {
  String _selectedIntensity = 'Baja';
  List _exercises = [];
  String _searchQuery = '';
  bool _isLoading = false;
  final ApiService apiService = ApiService('http://192.168.0.15:8080'); // Instancia de ApiService

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  Future<void> _fetchExercises() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String url;
      if (_searchQuery.isNotEmpty) {
        url = 'https://api.api-ninjas.com/v1/exercises?name=$_searchQuery';
      } else {
        String type;
        switch (_selectedIntensity) {
          case 'Baja':
            type = 'stretching';
            break;
          case 'Media':
            type = 'cardio';
            break;
          case 'Alta':
            type = 'strength';
            break;
          default:
            type = 'stretching';
        }
        url = 'https://api.api-ninjas.com/v1/exercises?type=$type';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-Api-Key': '9n6QBE/UGjmNiPJNDCNOuw==PAeMdqDaWkU5Ng0k',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _exercises = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (e) {
      setState(() {
        _exercises = [];
      });
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _savePhysicalActivity(String activityName) async {
    try {
      final physicalActivity = PhysicalActivity(
        nombre: activityName,
        date: widget.date,  // Usar la fecha pasada a la pantalla
        time: TimeOfDay.now(),
      );

      await apiService.savePhysicalActivity(physicalActivity);

      Navigator.pop(context, true);
    } catch (e) {
      print('Error al guardar actividad física: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar actividad física: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividad Física'),
        backgroundColor: const Color(0xFFC0DEF4),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: const Color(0xFFC0DEF4),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedIntensity = newValue!;
                          _searchQuery = ''; // Clear search query when intensity changes
                          _fetchExercises();
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Buscar por nombre:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Ingresar nombre del ejercicio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                onSubmitted: (value) {
                  _fetchExercises();
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Sugerencias:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _exercises.isEmpty
                        ? const Center(child: Text('No se encontraron ejercicios'))
                        : ListView.builder(
                            itemCount: _exercises.length,
                            itemBuilder: (context, index) {
                              return ActivitySuggestionCard(
                                activity: _exercises[index]['name'],
                                duration: '20-30 minutos',
                                info: _exercises[index]['instructions'],
                                onSave: () => _savePhysicalActivity(_exercises[index]['name']),
                              );
                            },
                          ),
              ),
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
  final VoidCallback onSave;

  const ActivitySuggestionCard({
    required this.activity,
    required this.duration,
    required this.info,
    required this.onSave,
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
            TextButton(
              child: const Text('Guardar'),
              onPressed: () {
                onSave();
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
