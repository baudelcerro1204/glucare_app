import 'package:flutter/material.dart';

class DayDetailsScreen extends StatefulWidget {
  final DateTime date;

  const DayDetailsScreen({super.key, required this.date});

  @override
  _DayDetailsScreenState createState() => _DayDetailsScreenState();
}

class _DayDetailsScreenState extends State<DayDetailsScreen> {
  bool _hadHypoHyper = false;
  String _insulinDose = '';
  String _physicalActivity = '';
  String _foodIntake = '';
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFE3F2FD),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        '${widget.date.day}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 48), // Espacio para equilibrar el diseño
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Episodios de hipoglucemia o hiperglucemia:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _hadHypoHyper = true;
                          });
                        },
                        child: Text('SI'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _hadHypoHyper ? Colors.blue : Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _hadHypoHyper = false;
                          });
                        },
                        child: Text('NO'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !_hadHypoHyper ? Colors.blue : Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildDetailCard('Dosis de insulina aplicada', Icons.edit, (value) {
                    setState(() {
                      _insulinDose = value;
                    });
                  }),
                  SizedBox(height: 20),
                  _buildDetailCard('Actividad física realizada', Icons.fitness_center, (value) {
                    setState(() {
                      _physicalActivity = value;
                    });
                  }),
                  SizedBox(height: 20),
                  _buildDetailCard('Alimentos ingeridos', Icons.restaurant, (value) {
                    setState(() {
                      _foodIntake = value;
                    });
                  }),
                  SizedBox(height: 20),
                  _buildDetailCard('Notas', Icons.note, (value) {
                    setState(() {
                      _notes = value;
                    });
                  }),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Aquí puedes guardar la información en una base de datos o algún otro almacenamiento
                        Navigator.pop(context);
                      },
                      child: const Text('Guardar'),
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

  Widget _buildDetailCard(String label, IconData icon, Function(String) onChanged) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: label,
                  border: InputBorder.none,
                ),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
