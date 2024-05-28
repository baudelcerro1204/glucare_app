import 'package:flutter/material.dart';

class TagScreen extends StatelessWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etiquetas'),
      ),
      body: Center(
        child: Text('Pantalla de Etiquetas'),
      ),
    );
  }
}
