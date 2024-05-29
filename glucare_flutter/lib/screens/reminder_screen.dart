import 'package:flutter/material.dart';

class Reminder {
  String title;
  String description;
  DateTime date;
  TimeOfDay time;
  List<bool> repeatDays;
  String etiqueta;
  Color color;

  Reminder({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.repeatDays,
    required this.etiqueta,
    required this.color,
  });
}
