import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<void> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }

  Future<void> login(String correoElectronico, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correoElectronico': correoElectronico,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        print('Login exitoso');
        // Procesa la respuesta aquí
      } else {
        print('Error de login: ${response.statusCode}');
        print('Mensaje del servidor: ${response.body}');
      }
    } catch (e) {
      print('Excepción: $e');
    }
  }

  Future<Map<String, dynamic>> searchFood(String query) async {
    const String appId = 'be89c2af';
    const String appKey = '1399075e20f27558d811e1b85c38b972';

    final response = await http.get(
      Uri.parse('https://api.edamam.com/api/food-database/v2/parser?ingr=$query&app_id=$appId&app_key=$appKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener información nutricional: ${response.body}');
    }
  }
}
