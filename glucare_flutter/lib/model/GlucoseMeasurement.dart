import 'package:flutter/material.dart';

class GlucoseMeasurement {
  double value;
  DateTime date;
  TimeOfDay time;
  int? userId;

  GlucoseMeasurement({
    required this.value,
    required this.date,
    required this.time,
    this.userId,
  });

  Map<String, dynamic> toJson() {
  return {
    'value': value,
    'date': date.toIso8601String().split('T')[0],
    'time': '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
    'userId': userId,
  };
}


  factory GlucoseMeasurement.fromJson(Map<String, dynamic> json) {
    return GlucoseMeasurement(
      value: json['value'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(':')[0]),
        minute: int.parse(json['time'].split(':')[1]),
      ),
    );
  }
}