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
    final loginData = {
      'correoElectronico': correoElectronico,
      'password': password,
    };
    print('Enviando solicitud de login con datos: $loginData');

    final response = await _postWithNoRedirect(
      Uri.parse('$baseUrl/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginData),
    );

    print('Respuesta del servidor: ${response.statusCode} - ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Email o contraseña incorrectos: ${response.body}');
    }
  }

  Future<http.Response> _postWithNoRedirect(Uri url, {Map<String, String>? headers, Object? body}) async {
    final client = http.Client();
    final request = http.Request('POST', url)
      ..headers.addAll(headers ?? {})
      ..body = body as String;

    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.isRedirect) {
      final redirectUrl = response.headers['location'];
      if (redirectUrl != null) {
        final redirectResponse = await client.get(Uri.parse(redirectUrl));
        return http.Response(redirectResponse.body, redirectResponse.statusCode, headers: redirectResponse.headers);
      } else {
        throw Exception('Redirección sin URL de destino');
      }
    } else {
      return response;
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
