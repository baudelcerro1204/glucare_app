import 'package:flutter/material.dart';

class RepeatScreen extends StatefulWidget {
  final List<bool> selectedDays;

  const RepeatScreen({Key? key, required this.selectedDays}) : super(key: key);

  @override
  _RepeatScreenState createState() => _RepeatScreenState();
}

class _RepeatScreenState extends State<RepeatScreen> {
  late List<bool> _selectedDays;

  @override
  void initState() {
    super.initState();
    _selectedDays = List.from(widget.selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repetir'),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
            title: Text('Lunes'),
            value: _selectedDays[0],
            onChanged: (bool? value) {
              setState(() {
                _selectedDays[0] = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Martes'),
            value: _selectedDays[1],
            onChanged: (bool? value) {
              setState(() {
                _selectedDays[1] = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Miércoles'),
            value: _selectedDays[2],
            onChanged: (bool? value) {
              setState(() {
                _selectedDays[2] = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Jueves'),
            value: _selectedDays[3],
            onChanged: (bool? value) {
              setState(() {
                _selectedDays[3] = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Viernes'),
            value: _selectedDays[4],
            onChanged: (bool? value) {
              setState(() {
                _selectedDays[4] = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Sábado'),
            value: _selectedDays[5],
            onChanged: (bool? value) {
              setState(() {
                _selectedDays[5] = value ?? false;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Domingo'),
            value: _selectedDays[6],
            onChanged: (bool? value) {
              setState(() {
                _selectedDays[6] = value ?? false;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _selectedDays);
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
