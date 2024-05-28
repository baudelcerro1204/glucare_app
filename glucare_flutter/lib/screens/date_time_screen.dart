import 'package:flutter/material.dart';

class DateTimeScreen extends StatelessWidget {
  const DateTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fecha y Hora'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/repeat');
              },
              child: Text('Repetir'),
            ),
          ],
        ),
      ),
    );
  }
}
