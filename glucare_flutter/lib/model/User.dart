import 'package:glucare/model/DiaryEntry.dart';
import 'package:glucare/model/FoodItem.dart';
import 'package:glucare/model/Medicine.dart';
import 'package:glucare/model/PhysicalActivity.dart';
import 'package:glucare/model/Reminder.dart';
import 'package:glucare/model/VirtualPet.dart';

class User {
  final int id;
  final String nombre;
  final String correoElectronico;
  final int edad;
  final int diabetesTipo;
  final VirtualPet mascotaVirtual;
  final List<DiaryEntry> historialDiario;
  final List<Medicine> medicamentos;
  final List<FoodItem> alimentacion;
  final List<PhysicalActivity> actividadFisica;
  final List<Reminder> recordatorios;

  User({
    required this.id,
    required this.nombre,
    required this.correoElectronico,
    required this.edad,
    required this.diabetesTipo,
    required this.mascotaVirtual,
    required this.historialDiario,
    required this.medicamentos,
    required this.alimentacion,
    required this.actividadFisica,
    required this.recordatorios,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      correoElectronico: json['correoElectronico'],
      edad: json['edad'],
      diabetesTipo: json['diabetesTipo'],
      mascotaVirtual: VirtualPet.fromJson(json['mascotaVirtual']),
      historialDiario: (json['historialDiario'] as List)
          .map((i) => DiaryEntry.fromJson(i))
          .toList(),
      medicamentos: (json['medicamentos'] as List)
          .map((i) => Medicine.fromJson(i))
          .toList(),
      alimentacion: (json['alimentacion'] as List)
          .map((i) => FoodItem.fromJson(i))
          .toList(),
      actividadFisica: (json['actividadFisica'] as List)
          .map((i) => PhysicalActivity.fromJson(i))
          .toList(),
      recordatorios: (json['recordatorios'] as List)
          .map((i) => Reminder.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correoElectronico': correoElectronico,
      'edad': edad,
      'diabetesTipo': diabetesTipo,
      'mascotaVirtual': mascotaVirtual.toJson(),
      'historialDiario':
          historialDiario.map((entry) => entry.toJson()).toList(),
      'medicamentos': medicamentos.map((medicine) => medicine.toJson()).toList(),
      'alimentacion': alimentacion.map((foodItem) => foodItem.toJson()).toList(),
      'actividadFisica': actividadFisica.map((activity) => activity.toJson()).toList(),
      'recordatorios': recordatorios.map((reminder) => reminder.toJson()).toList(),
    };
  }
}