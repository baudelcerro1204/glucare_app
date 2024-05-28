import 'package:flutter/material.dart';

class FilterRemindersScreen extends StatelessWidget {
  const FilterRemindersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Recordatorios'),
      ),
      body: Center(
        child: Text('Pantalla de Filtrar Recordatorios'),
      ),
    );
  }
}
