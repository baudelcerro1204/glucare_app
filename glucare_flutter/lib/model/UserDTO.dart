class UserDTO {
  final String nombre;
  final String correoElectronico;
  final int edad;

  UserDTO({
    required this.nombre,
    required this.correoElectronico,
    required this.edad,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      nombre: json['nombre'],
      correoElectronico: json['correoElectronico'],
      edad: json['edad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'correoElectronico': correoElectronico,
      'edad': edad,
    };
  }
}
