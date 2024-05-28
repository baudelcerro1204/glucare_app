import 'package:flutter/material.dart';
import 'package:glucare/model/User.dart';
import 'package:uuid/uuid.dart';

class Reminder {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final List<bool> repeatDays;
  final String? etiqueta;
  final User user;

  Reminder({
    String? id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.repeatDays,
    this.etiqueta,
    required this.user,
  }) : id = id ?? const Uuid().v4();

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(":")[0]),
        minute: int.parse(json['time'].split(":")[1]),
      ),
      repeatDays: List<bool>.from(json['repeatDays']),
      etiqueta: json['etiqueta'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'time': time.formatToJson(),
      'repeatDays': repeatDays,
      'etiqueta': etiqueta,
      'user': user.toJson(),
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
