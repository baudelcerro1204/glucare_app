import 'package:glucare/model/User.dart';

class PhysicalActivity {
  final int id;
  final String tipo;
  final String intensidad;
  final int duracion;
  final User user;

  PhysicalActivity({
    required this.id,
    required this.tipo,
    required this.intensidad,
    required this.duracion,
    required this.user,
  });

  factory PhysicalActivity.fromJson(Map<String, dynamic> json) {
    return PhysicalActivity(
      id: json['id'],
      tipo: json['tipo'],
      intensidad: json['intensidad'],
      duracion: json['duracion'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'intensidad': intensidad,
      'duracion': duracion,
      'user': user.toJson(),
    };
  }
}