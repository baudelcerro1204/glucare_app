import 'package:flutter/material.dart';

class Reminder {
  String title;
  String description;
  DateTime date;
  TimeOfDay time;
  List<bool> repeatDays;
  String? etiqueta; // Nueva propiedad para la etiqueta

  Reminder({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.repeatDays,
    this.etiqueta, String? tag, // Parámetro opcional para la etiqueta
  });
}
