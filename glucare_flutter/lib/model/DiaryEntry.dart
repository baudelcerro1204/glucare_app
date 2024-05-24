import 'package:flutter/material.dart';
import 'package:glucare/model/FoodItem.dart';
import 'package:glucare/model/Medicine.dart';
import 'package:glucare/model/Mood.dart';
import 'package:glucare/model/PhysicalActivity.dart';
import 'package:glucare/model/User.dart';

class DiaryEntry {
  final int id;
  final DateTime fecha;
  final TimeOfDay hora;
  final Mood estadoAnimo;
  final List<Medicine> medicamentosTomados;
  final List<FoodItem> alimentosConsumidos;
  final PhysicalActivity actividadFisicaRealizada;
  final User user;

  DiaryEntry({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.estadoAnimo,
    required this.medicamentosTomados,
    required this.alimentosConsumidos,
    required this.actividadFisicaRealizada,
    required this.user,
  });

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'],
      fecha: DateTime.parse(json['fecha']),
      hora: TimeOfDay(
        hour: int.parse(json['hora'].split(':')[0]),
        minute: int.parse(json['hora'].split(':')[1]),
      ),
      estadoAnimo: Mood.fromJson(json['estadoAnimo']),
      medicamentosTomados: (json['medicamentosTomados'] as List)
          .map((i) => Medicine.fromJson(i))
          .toList(),
      alimentosConsumidos: (json['alimentosConsumidos'] as List)
          .map((i) => FoodItem.fromJson(i))
          .toList(),
      actividadFisicaRealizada:
          PhysicalActivity.fromJson(json['actividadFisicaRealizada']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'hora': '${hora.hour}:${hora.minute}',
      'estadoAnimo': estadoAnimo.toJson(),
      'medicamentosTomados':
          medicamentosTomados.map((medicine) => medicine.toJson()).toList(),
      'alimentosConsumidos':
          alimentosConsumidos.map((foodItem) => foodItem.toJson()).toList(),
      'actividadFisicaRealizada': actividadFisicaRealizada.toJson(),
      'user': user.toJson(),
    };
  }
}
