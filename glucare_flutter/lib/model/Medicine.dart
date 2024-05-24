import 'package:glucare/model/User.dart';

class Medicine {
  final int id;
  final String nombre;
  final double dosis;
  final String frecuencia;
  final User user;

  Medicine({
    required this.id,
    required this.nombre,
    required this.dosis,
    required this.frecuencia,
    required this.user,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      nombre: json['nombre'],
      dosis: json['dosis'],
      frecuencia: json['frecuencia'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'dosis': dosis,
      'frecuencia': frecuencia,
      'user': user.toJson(),
    };
  }
}