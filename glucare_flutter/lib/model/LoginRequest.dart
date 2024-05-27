class LoginRequest {
  late String correoElectronico;
  late String password;

  LoginRequest({required this.correoElectronico, required this.password});

  LoginRequest.fromJson(Map<String, dynamic> json)
      : correoElectronico = json['correoElectronico'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'correoElectronico': correoElectronico,
        'password': password,
      };
}
