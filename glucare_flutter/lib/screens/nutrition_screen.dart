import 'package:flutter/material.dart';
import 'package:glucare/services/api_service.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final ApiService apiService = ApiService('https://api.edamam.com');
  String _searchTerm = '';
  List<Map<String, dynamic>> _foods = [];
  bool _isLoading = false;
  String _errorMessage = '';

  void _searchFood(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final foodData = await apiService.searchFood(query);
      final List<Map<String, dynamic>> foods = (foodData['hints'] as List)
          .map((item) => item['food'] as Map<String, dynamic>)
          .toList();

      setState(() {
        _foods = foods;
        _isLoading = false;
      });
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
              setState(() {
                _foods = [];
              });
            }
          },
          decoration: const InputDecoration(
            hintText: 'Buscar alimento...',
          ),
        ),
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
                        final food = _foods[index];
                        return ListTile(
                          title: Text(food['label']),
                          subtitle: Text(
                            'Calorías: ${food['nutrients']['ENERC_KCAL']?.toString() ?? 'N/A'} kcal',
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(food['label']),
                                content: Text(
                                  'Información Nutricional:\n\n'
                                  'Calorías: ${food['nutrients']['ENERC_KCAL']?.toString() ?? 'N/A'} kcal\n'
                                  'Proteínas: ${food['nutrients']['PROCNT']?.toString() ?? 'N/A'} g\n'
                                  'Grasas: ${food['nutrients']['FAT']?.toString() ?? 'N/A'} g\n'
                                  'Carbohidratos: ${food['nutrients']['CHOCDF']?.toString() ?? 'N/A'} g',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cerrar'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
    );
  }
}
