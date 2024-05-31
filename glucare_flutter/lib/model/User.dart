import 'package:glucare/model/Reminder.dart';
import 'package:glucare/model/VirtualPet.dart';

class User {
  final int id;
  final String nombre;
  final String correoElectronico;
  final int edad;
  final int diabetesTipo;
  final VirtualPet mascotaVirtual;
  final List<Reminder> recordatorios;

  User({
    required this.id,
    required this.nombre,
    required this.correoElectronico,
    required this.edad,
    required this.diabetesTipo,
    required this.mascotaVirtual,
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
      'recordatorios': recordatorios.map((reminder) => reminder.toJson()).toList(),
    };
  }
}