import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class ApiService {
  final String baseUrl;
  final String appId = 'be89c2af';
  final String appKey = '1399075e20f27558d811e1b85c38b972';

  final String apiKey = '8770f277a20542d3a5e9478e10ae44e2';
final String region = 'brazilsouth';

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
    final loginData = {
      'correoElectronico': correoElectronico,
      'password': password,
    };
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginData),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getFoodInfo(String query) async {
    final response = await http.get(
      Uri.parse('https://api.edamam.com/api/food-database/v2/parser?ingr=$query&app_id=$appId&app_key=$appKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener información nutricional: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> searchFood(String query) async {
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
