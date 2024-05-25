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
      appBar: AppBar(
        title: Text('Detalles del día ${widget.date.day}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Episodios de hipoglucemia o hiperglucemia:'),
                  Switch(
                    value: _hadHypoHyper,
                    onChanged: (value) {
                      setState(() {
                        _hadHypoHyper = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Dosis de insulina aplicada',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _insulinDose = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Actividad física realizada',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _physicalActivity = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Alimentos ingeridos',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _foodIntake = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Notas',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _notes = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes guardar la información en una base de datos o algún otro almacenamiento
                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
