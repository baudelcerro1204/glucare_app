import 'package:flutter/material.dart';

class Prediction {
  final int id;
  final DateTime fecha;
  final TimeOfDay hora;
  final String prediccion;

  Prediction({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.prediccion,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      id: json['id'],
      fecha: DateTime.parse(json['fecha']),
      hora: TimeOfDay(
        hour: int.parse(json['hora'].split(':')[0]),
        minute: int.parse(json['hora'].split(':')[1]),
      ),
      prediccion: json['prediccion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'hora': '${hora.hour}:${hora.minute}',
      'prediccion': prediccion,
    };
  }
}