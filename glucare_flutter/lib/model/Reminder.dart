import 'package:flutter/material.dart';

class Reminder {
  final int? id;  // Hacer el ID nullable
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final List<bool> repeatDays;
  final String? etiqueta;

  Reminder({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.repeatDays,
    this.etiqueta,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],  // Asegurarse de que el ID se obtenga correctamente
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(":")[0]),
        minute: int.parse(json['time'].split(":")[1]),
      ),
      repeatDays: List<bool>.from(json['repeatDays']),
      etiqueta: json['etiqueta'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,  // Incluir el ID en el JSON
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'time': time.formatToJson(),
      'repeatDays': repeatDays,
      'etiqueta': etiqueta,
    };
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String formatToJson() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
