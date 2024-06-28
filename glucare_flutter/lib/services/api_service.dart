import 'dart:convert';
import 'package:glucare/model/CommunityPost.dart';
import 'package:glucare/model/Food.dart';
import 'package:glucare/model/GlucoseMeasurement.dart';
import 'package:glucare/model/MonthlyAverage.dart';
import 'package:glucare/model/PhysicalActivity.dart';
import 'package:glucare/model/Reminder.dart';
import 'package:glucare/model/UserDTO.dart';
import 'package:glucare/model/WeeklyAverage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<void> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
    else {
    }
  }

  Future<void> login(String correoElectronico, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'correoElectronico': correoElectronico,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      final userId = responseData['userId']; // Obtener el userId
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      await prefs.setInt('user_id', userId);
    } else {
      throw Exception('Error de login: ${response.statusCode}');
    }
  }

  Future<void> logout() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/auth/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      print('Server response: ${response.body}');
      throw Exception('Failed to logout');
    }
  }

  Future<UserDTO> getUserProfile() async {
  final token = await _getToken();
  final userId = await _getUserId(); 
  if (token == null) {
    throw Exception('Token no encontrado');
  }
  if (userId == null) {
    throw Exception('User ID no encontrado');
  }

  final response = await http.get(
    Uri.parse('$baseUrl/users/profile/$userId'), 
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return UserDTO.fromJson(responseData);
  } else if (response.statusCode == 403) {
    throw Exception('Error de autorización: ${response.statusCode} ${response.body}');
  } else {
    throw Exception('Error al obtener perfil de usuario: ${response.statusCode} ${response.body}');
  }
}

  Future<void> updateUserProfile(UserDTO userData) async {
  final token = await _getToken();
  final userId = await _getUserId();

  if (token == null || userId == null) {
    throw Exception('No se pudo obtener el token o el userId.');
  }

  final response = await http.put(
    Uri.parse('$baseUrl/users/update/$userId'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(userData.toJson()), // Convertir el objeto UserDTO a JSON
  );

  if (response.statusCode != 200) {
    throw Exception('Error al actualizar perfil de usuario: ${response.statusCode}');
  }
}

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

    Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<void> saveReminder(Reminder reminder) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final requestBody = jsonEncode(reminder.toJson());

    final response = await http.post(
      Uri.parse('$baseUrl/reminders/save'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody,
    );


    if (response.statusCode != 200) {
      throw Exception('Error al guardar recordatorio: ${response.body}');
    }
  }

  Future<List<Reminder>> getReminders() async {
    final token = await _getToken();
    final userId = await _getUserId(); // Asegúrate de obtener el userId aquí
    if (token == null) {
      throw Exception('Token no encontrado');
    }
    if (userId == null) {
      throw Exception('User ID no encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/reminders/getAll?userId=$userId'), // Incluye el userId en la solicitud
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );


    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => Reminder.fromJson(json)).toList();
    } else if (response.statusCode == 403) {
      throw Exception('Error de autorización: ${response.statusCode} ${response.body}');
    } else {
      throw Exception('Error al obtener recordatorios: ${response.statusCode} ${response.body}');
    }
  }

  Future<void> updateReminder(int id, Reminder reminder) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final requestBody = jsonEncode(reminder.toJson());

    final response = await http.put(
      Uri.parse('$baseUrl/reminders/update/$id'), // Usar el ID del recordatorio en la URL
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody,
    );


    if (response.statusCode != 200) {
      throw Exception('Error al actualizar recordatorio: ${response.body}');
    }
  }

  Future<void> deleteReminder(int id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/reminders/delete/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );


    if (response.statusCode != 200) {
      throw Exception('Error al eliminar recordatorio: ${response.body}');
    }
  }

  Future<CommunityPost> createPost(CommunityPost post) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/posts/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return CommunityPost.fromJson(jsonDecode(response.body));
    } else {
      print('Error: ${response.statusCode} ${response.body}');
      throw Exception('Error al crear publicación: ${response.body}');
    }
  }

  Future<List<CommunityPost>> getPosts() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/posts/getAll'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => CommunityPost.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener publicaciones: ${response.body}');
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
  
    Future<List<Reminder>> getRemindersByDate(DateTime date) async {
    final token = await _getToken();
    final userId = await _getUserId();
    if (token == null) {
      throw Exception('Token no encontrado');
    }
    if (userId == null) {
      throw Exception('User ID no encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/reminders/byDate?userId=$userId&date=${date.toIso8601String().split('T')[0]}'), 
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => Reminder.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener recordatorios: ${response.statusCode} ${response.body}');
    }
  }

    
    Future<void> saveGlucoseMeasurement(GlucoseMeasurement glucoseMeasurement) async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      throw Exception('Token o user ID no encontrado');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/glucose/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(glucoseMeasurement.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al guardar medición de glucosa: ${response.statusCode}');
    }
  }

  Future<List<GlucoseMeasurement>> getGlucoseMeasurements() async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      throw Exception('Token o user ID no encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/glucose/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => GlucoseMeasurement.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener mediciones de glucosa: ${response.body}');
    }
  }

  Future<void> updateGlucoseMeasurement(int measurementId, GlucoseMeasurement glucoseMeasurement) async {
    final token = await _getToken();

    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/glucose/$measurementId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(glucoseMeasurement.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar medición de glucosa: ${response.body}');
    }
  }

  Future<void> deleteGlucoseMeasurement(int measurementId) async {
    final token = await _getToken();

    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/glucose/$measurementId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar medición de glucosa: ${response.body}');
    }
  }

  Future<List<GlucoseMeasurement>> getGlucoseMeasurementsByDate(DateTime date) async {
  final token = await _getToken();
  final userId = await _getUserId();
  if (token == null) {
    throw Exception('Token no encontrado');
  }
  if (userId == null) {
    throw Exception('User ID no encontrado');
  }

  final response = await http.get(
    Uri.parse('$baseUrl/glucose/byDate?userId=$userId&date=${date.toIso8601String().split('T')[0]}'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);
    return responseData.map((json) => GlucoseMeasurement.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener mediciones de glucosa: ${response.statusCode} ${response.body}');
  }
}

Future<void> savePhysicalActivity(PhysicalActivity physicalActivity) async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      throw Exception('Token o user ID no encontrado');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/activity/$userId'),
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(physicalActivity.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al guardar actividad fisica: ${response.statusCode}');
    }
  }

  Future<List<PhysicalActivity>> getPhysicalActivitiesByDate(DateTime date) async {
  final token = await _getToken();
  final userId = await _getUserId();
  if (token == null) {
    throw Exception('Token no encontrado');
  }
  if (userId == null) {
    throw Exception('User ID no encontrado');
  }

  final response = await http.get(
    Uri.parse('$baseUrl/activity/byDate?userId=$userId&date=${date.toIso8601String().split('T')[0]}'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);
    return responseData.map((json) => PhysicalActivity.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener actividades fisicas: ${response.statusCode} ${response.body}');
  }
}

Future<void> saveFood(Food food) async {
  final token = await _getToken();
  final userId = await _getUserId();

  if (token == null || userId == null) {
    throw Exception('Token o user ID no encontrado');
  }

  final response = await http.post(
    Uri.parse('$baseUrl/food/$userId'),
    headers: { 
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',  // Asegúrate de que el token esté presente
    },
    body: jsonEncode(food.toJson()),  // Asegúrate de que el body sea correcto
  );

  if (response.statusCode != 200) {
    print('Error al guardar comida: ${response.statusCode} ${response.body}');
    throw Exception('Error al guardar comida: ${response.statusCode}');
  }
}


  Future<List<Food>> getFoodsByDate(DateTime date) async {
  final token = await _getToken();
  final userId = await _getUserId();
  if (token == null) {
    throw Exception('Token no encontrado');
  }
  if (userId == null) {
    throw Exception('User ID no encontrado');
  }

  final response = await http.get(
    Uri.parse('$baseUrl/food/byDate?userId=$userId&date=${date.toIso8601String().split('T')[0]}'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);
    return responseData.map((json) => Food.fromJson(json)).toList();
  } else {
    throw Exception('Error al obtener comidas: ${response.statusCode} ${response.body}');
  }
}

 Future<Map<String, double>> getDailyAverageGlucose() async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      throw Exception('Token o user ID no encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/glucose/daily-average/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return Map.fromIterable(responseData,
          key: (e) => e['date'] as String,
          value: (e) => e['averageValue'] as double);
    } else {
      throw Exception('Error al obtener el promedio diario de glucosa: ${response.statusCode}');
    }
  }

   Future<Map<String, WeeklyAverage>> getWeeklyAverageGlucose() async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      throw Exception('Token o user ID no encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/glucose/weekly-average/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return Map.fromIterable(responseData,
          key: (e) => 'Semana ${e['week']} de ${e['year']}',
          value: (e) => WeeklyAverage.fromJson(e));
    } else {
      throw Exception('Error al obtener el promedio semanal de glucosa: ${response.statusCode}');
    }
  }

  Future<Map<String, MonthlyAverage>> getMonthlyAverageGlucose() async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      throw Exception('Token o user ID no encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/glucose/monthly-average/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return Map.fromIterable(responseData,
          key: (e) => '${e['month']}/${e['year']}',
          value: (e) => MonthlyAverage.fromJson(e));
    } else {
      throw Exception('Error al obtener el promedio mensual de glucosa: ${response.statusCode}');
    }
  }

   Future<List<GlucoseMeasurement>> getGlucoseHistory() async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      throw Exception('Token o user ID no encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/glucose/history/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => GlucoseMeasurement.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener el historial de glucosa: ${response.statusCode}');
    }
  }
}
