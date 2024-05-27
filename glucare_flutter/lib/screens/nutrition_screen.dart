import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:glucare/services/api_service.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final ApiService apiService = ApiService('https://platform.fatsecret.com/rest/server.api');
  final String apiKey = 'bb17c699dff04e9ea9f641fdba3b5697'; // API Key de FatSecret
  final String apiSecret = '9fe62b5da1da4849ae4dbf9289d89b73'; // API Secret de FatSecret

  String _searchTerm = '';
  String _selectedFilter = 'All'; // Inicialmente, muestra todos los alimentos
  List<String> _foods = []; // Lista de alimentos obtenidos de la API
  bool _isLoading = false; // Estado de carga
  String _errorMessage = ''; // Mensaje de error

  @override
  void initState() {
    super.initState();
    _loadDefaultFoods();
  }

  void _loadDefaultFoods() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await apiService.searchFood('default', apiKey, apiSecret); // 'default' es una búsqueda general para obtener alimentos por defecto
      print('Response Body: ${response.body}'); // Imprime el cuerpo de la respuesta en la consola
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          if (data['foods'] != null && data['foods']['food'] != null) {
            _foods = (data['foods']['food'] as List)
                .map((food) => food['food_name'] as String)
                .toList();
          } else {
            _foods = [];
          }
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.body}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _searchFood(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await apiService.searchFood(query, apiKey, apiSecret);
      print('Response Body: ${response.body}'); // Imprime el cuerpo de la respuesta en la consola
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          if (data['foods'] != null && data['foods']['food'] != null) {
            _foods = (data['foods']['food'] as List)
                .map((food) => food['food_name'] as String)
                .toList();
          } else {
            _foods = [];
          }
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.body}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
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
            } else {
              _loadDefaultFoods(); // Carga alimentos por defecto si el campo de búsqueda está vacío
            }
          },
          decoration: const InputDecoration(
            hintText: 'Search food...',
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'All',
                child: Text('All'),
              ),
              const PopupMenuItem(
                value: 'Carbohydrates',
                child: Text('Carbohydrates'),
              ),
              const PopupMenuItem(
                value: 'Proteins',
                child: Text('Proteins'),
              ),
              const PopupMenuItem(
                value: 'Fats',
                child: Text('Fats'),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _foods.isEmpty
                  ? const Center(child: Text('No se encontraron resultados'))
                  : ListView.builder(
                      itemCount: _foods.length,
                      itemBuilder: (context, index) {
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
