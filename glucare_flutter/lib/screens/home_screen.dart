import 'package:flutter/material.dart';
import 'information_screen.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _messages = [
    '¡Hola! user_id, ¿cómo te encuentras hoy?',
    'Recuerda beber agua y mantenerte hidratado.',
    '¡Vamos a hacer algo de ejercicio hoy!',
    '¡Eres increíble, sigue así!',
    'No olvides comer tus frutas y verduras.',
  ];
  int _currentMessageIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startMessageRotation();
  }

  void _startMessageRotation() {
    _timer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      setState(() {
        _currentMessageIndex = (_currentMessageIndex + 1) % _messages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC0DEF4), // Fondo color celeste
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0DEF4),
        leading: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const InformationScreen()),
            );
          },
        ),
        title: const Text('Inicio'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                _messages[_currentMessageIndex],
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Image.asset(
            'lib/assets/glucare_panda_saludando.png', // Cambia esto a la ruta de tu imagen
            height: 200, // Ajusta el tamaño según sea necesario
          ),
        ],
      ),
    );
  }
}
