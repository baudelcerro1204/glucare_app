import 'package:flutter/material.dart';

class Food {
  String nombre;
  String calorias;
  String proteinas;
  String grasas;
  String carbohidratos;
  DateTime date;
  TimeOfDay time;
  int? userId;

  Food({
    required this.nombre,
    required this.calorias,
    required this.proteinas,
    required this.grasas,
    required this.carbohidratos,
    required this.date,
    required this.time,
    this.userId,
  });

  Map<String, dynamic> toJson() {
  return {
    'nombre': nombre,
    'calorias': calorias,
    'proteinas': proteinas,
    'grasas': grasas,
    'carbohidratos': carbohidratos,
    'date': date.toIso8601String().split('T')[0],
    'time': '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
    'userId': userId,
  };
}


  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      nombre: json['nombre'],
      calorias: json['calorias'],
      proteinas: json['proteinas'],
      grasas: json['grasas'],
      carbohidratos: json['carbohidratos'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(':')[0]),
        minute: int.parse(json['time'].split(':')[1]),
      ),
      userId: json['userId'],
    );
  }
}
