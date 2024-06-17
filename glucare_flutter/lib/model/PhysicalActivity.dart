import 'package:flutter/material.dart';

class PhysicalActivity{
  String nombre;
  DateTime date;
  TimeOfDay time;
  int? userId;

  PhysicalActivity({
    required this.nombre,
    required this.date,
    required this.time,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'date': date.toIso8601String().split('T')[0],
      'time': '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
      'userId': userId,
    };
  }

  factory PhysicalActivity.fromJson(Map<String, dynamic> json) {
    return PhysicalActivity(
      nombre: json['nombre'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(':')[0]),
        minute: int.parse(json['time'].split(':')[1]),
      ),
      userId: json['userId'],
    );
  }
}
