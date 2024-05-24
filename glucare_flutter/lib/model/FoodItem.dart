import 'package:glucare/model/User.dart';

class FoodItem {
  final int id;
  final String nombre;
  final double cantidadCarbohidratos;
  final double cantidadProteinas;
  final double cantidadGrasas;
  final User user;

  FoodItem({
    required this.id,
    required this.nombre,
    required this.cantidadCarbohidratos,
    required this.cantidadProteinas,
    required this.cantidadGrasas,
    required this.user,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      nombre: json['nombre'],
      cantidadCarbohidratos: json['cantidadCarbohidratos'],
      cantidadProteinas: json['cantidadProteinas'],
      cantidadGrasas: json['cantidadGrasas'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'cantidadCarbohidratos': cantidadCarbohidratos,
      'cantidadProteinas': cantidadProteinas,
      'cantidadGrasas': cantidadGrasas,
      'user': user.toJson(),
    };
  }
}