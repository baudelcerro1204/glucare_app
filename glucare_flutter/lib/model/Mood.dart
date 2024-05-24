import 'package:flutter/material.dart';

class Mood {
  final int id;
  final DateTime fecha;
  final TimeOfDay hora;
  final String estado;
  final String descripcion;

  Mood({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.estado,
    required this.descripcion,
  });

  factory Mood.fromJson(Map<String, dynamic> json) {
    return Mood(
      id: json['id'],
      fecha: DateTime.parse(json['fecha']),
      hora: TimeOfDay(
        hour: int.parse(json['hora'].split(':')[0]),
        minute: int.parse(json['hora'].split(':')[1]),
      ),
      estado: json['estado'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'hora': '${hora.hour}:${hora.minute}',
      'estado': estado,
      'descripcion': descripcion,
    };
  }
}
