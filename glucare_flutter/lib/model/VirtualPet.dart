import 'package:glucare/model/User.dart';

class VirtualPet {
  final int id;
  final String nombre;
  final String estado;
  final int nivelHambre;
  final int nivelFelicidad;
  final int nivelEnergia;
  final User user;

  VirtualPet({
    required this.id,
    required this.nombre,
    required this.estado,
    required this.nivelHambre,
    required this.nivelFelicidad,
    required this.nivelEnergia,
    required this.user,
  });

  factory VirtualPet.fromJson(Map<String, dynamic> json) {
    return VirtualPet(
      id: json['id'],
      nombre: json['nombre'],
      estado: json['estado'],
      nivelHambre: json['nivelHambre'],
      nivelFelicidad: json['nivelFelicidad'],
      nivelEnergia: json['nivelEnergia'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'estado': estado,
      'nivelHambre': nivelHambre,
      'nivelFelicidad': nivelFelicidad,
      'nivelEnergia': nivelEnergia,
      'user': user.toJson(),
    };
  }
}