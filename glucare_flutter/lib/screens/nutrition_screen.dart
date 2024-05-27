import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glucare/services/api_service.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final ApiService apiService = ApiService('http://localhost:8080');
  final String apiKey = 'bb17c699dff04e9ea9f641fdba3b5697'; // API Key de FatSecret
  final String apiSecret = '9fe62b5da1da4849ae4dbf9289d89b73'; // API Secret de FatSecret

  String _searchTerm = '';
  String _selectedFilter = 'All'; // Inicialmente, muestra todos los alimentos
  List<String> _foods = []; // Lista de alimentos obtenidos de la API

  void _searchFood(String query) async {
    final response = await apiService.searchFood(query, apiKey, apiSecret);

    // Imprime la respuesta de la API para depuración
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        // Verifica la estructura de la respuesta JSON
        if (data['foods'] != null && data['foods']['food'] != null) {
          _foods = (data['foods']['food'] as List)
              .map((food) => food['food_name'] as String)
              .toList();
        } else {
          _foods = []; // Si no hay resultados, limpia la lista
        }
      });
    } else {
      // Manejo de errores
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchTerm = value;
            });
            if (_searchTerm.isNotEmpty) {
              _searchFood(_searchTerm);
            }
          },
          decoration: InputDecoration(
            hintText: 'Search food...',
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'All',
                child: Text('All'),
              ),
              PopupMenuItem(
                value: 'Carbohydrates',
                child: Text('Carbohydrates'),
              ),
              PopupMenuItem(
                value: 'Proteins',
                child: Text('Proteins'),
              ),
              PopupMenuItem(
                value: 'Fats',
                child: const Text('Fats'),
              ),
            ],
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
                // Aquí deberías filtrar los alimentos basados en el valor seleccionado
                // Esto depende de cómo quieras manejar el filtrado de los resultados
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _foods.length,
        itemBuilder: (context, index) {
          // Aquí deberías construir los elementos de la lista de alimentos (_foods)
          return ListTile(
            title: Text(_foods[index]),
            // Agrega aquí la lógica para mostrar la descripción y la información nutricional al hacer clic en un alimento
            onTap: () {
              // Lógica para mostrar la descripción y la información nutricional
            },
          );
        },
      ),
    );
  }
}
