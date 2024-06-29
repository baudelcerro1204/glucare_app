import 'package:flutter/material.dart';

class PandaAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/panda_celebration.gif'), // Ruta de tu GIF de panda animado
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
