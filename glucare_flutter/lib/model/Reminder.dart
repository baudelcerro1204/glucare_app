import 'package:glucare/model/User.dart';

class Reminder {
  final int id;
  final DateTime fechaHoraRecordatorio;
  final String tipo;
  final String descripcion;
  final User user;

  Reminder({
    required this.id,
    required this.fechaHoraRecordatorio,
    required this.tipo,
    required this.descripcion,
    required this.user,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'],
      fechaHoraRecordatorio: DateTime.parse(json['fechaHoraRecordatorio']),
      tipo: json['tipo'],
      descripcion: json['descripcion'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fechaHoraRecordatorio': fechaHoraRecordatorio.toIso8601String(),
      'tipo': tipo,
      'descripcion': descripcion,
      'user': user.toJson(),
    };
  }
}