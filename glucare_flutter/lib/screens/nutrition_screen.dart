import 'package:flutter/material.dart';
import 'package:glucare/services/api_service.dart';
import 'package:glucare/model/Food.dart'; // Asegúrate de que la ruta y la capitalización sean correctas

class NutritionScreen extends StatefulWidget {
  final DateTime date;

  const NutritionScreen({Key? key, required this.date}) : super(key: key);

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final ApiService apiService = ApiService('http://192.168.0.15:8080');
  final ApiService foodService = ApiService('https://api.edamam.com');
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  List<Map<String, dynamic>> _foods = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedCategory = '';

  final List<String> _suggestions = [
    'Manzana',
    'Plátano',
    'Pollo',
    'Salmón',
    'Brócoli',
    'Avena',
    'Yogur',
    'Aguacate',
    'Huevos',
    'Tomate',
    'Espinaca',
    'Almendras',
    'Arándanos',
    'Quinoa',
    'Batata',
    'Pavo',
    'Mantequilla de maní',
    'Zanahorias',
    'Garbanzos'
  ];

  @override
  void initState() {
    super.initState();
    _fetchRandomSuggestions();
  }

  void _fetchRandomSuggestions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      List<String> randomSuggestions =
          (_suggestions..shuffle()).take(5).toList();
      for (String suggestion in randomSuggestions) {
        final foodData = await foodService.searchFood(suggestion);
        final List<Map<String, dynamic>> foods = (foodData['hints'] as List)
            .map((item) => item['food'] as Map<String, dynamic>)
            .toList();

        setState(() {
          _foods.addAll(foods);
        });
      }
      setState(() {
        _isLoading = false;
      });
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
      _selectedCategory = '';
    });

    try {
      final foodData = await foodService.searchFood(query);
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

  void _searchFoodByCategory(String category) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _foods = [];
      _selectedCategory = category;
    });

    try {
      final List<String> foodsToSearch = _categoryFoods[category]!
          .take((_categoryFoods[category]!.length / 2).round())
          .toList();

      for (String food in foodsToSearch) {
        final foodData = await foodService.searchFood(food);
        final List<Map<String, dynamic>> foods = (foodData['hints'] as List)
            .map((item) => item['food'] as Map<String, dynamic>)
            .toList();

        setState(() {
          _foods.addAll(foods);
        });
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveFood(Map<String, dynamic> foodData) async {
    try {
      final food = Food(
        nombre: foodData['label'],
        calorias: foodData['nutrients']['ENERC_KCAL'].toString(),
        proteinas: foodData['nutrients']['PROCNT'].toString(),
        grasas: foodData['nutrients']['FAT'].toString(),
        carbohidratos: foodData['nutrients']['CHOCDF'].toString(),
        date: widget.date,
        time: TimeOfDay.now(),
      );

      await apiService.saveFood(food);
      Navigator.pop(context, true); // Return true to indicate a successful save
    } catch (e) {
      print('Error al guardar comida: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar comida: $e')),
      );
    }
  }

  final Map<String, List<String>> _categoryFoods = {
    'Desayuno': [
      'Avena con Frutas',
      'Tostada con Aguacate',
      'Yogur Griego con Granola',
      'Huevos Revueltos con Espinacas y Tomates',
      'Batido de Frutas',
      'Panqueques de Trigo Integral',
      'Tazón de Acaí',
      'Omelette de Claras de Huevo',
      'Muffins de Arándanos',
      'Tostadas Francesas',
      'Pudín de Chía',
      'Burrito de Desayuno',
      'Quinoa con Leche',
      'Ensalada de Frutas',
      'Cereal Integral',
      'Bagel con Salmón Ahumado',
      'Revuelto de Tofu',
      'Sándwich de Desayuno',
      'Crepas de Trigo Integral',
      'Pan de Plátano'
    ],
    'Almuerzo': [
      'Ensalada César con Pollo',
      'Sándwich de Pavo',
      'Quinoa con Verduras Asadas',
      'Pasta con Pesto',
      'Sopa de Lentejas',
      'Ensalada Griega',
      'Wrap de Pollo',
      'Arroz Integral con Frijoles Negros',
      'Sushi Casero',
      'Chili Vegetariano',
      'Fajitas de Res',
      'Ensalada de Quinoa y Garbanzos',
      'Hamburguesas de Lentejas',
      'Lasaña de Verduras',
      'Pollo al Horno con Batatas',
      'Risotto de Espárragos',
      'Tortilla Española',
      'Ensalada de Atún',
      'Pizza Casera',
      'Sopa de Pollo con Verduras'
    ],
    'Merienda': [
      'Fruta Fresca',
      'Yogur Griego con Miel y Nueces',
      'Hummus con Palitos de Verdura',
      'Barra de Granola',
      'Batido de Proteínas',
      'Palitos de Queso',
      'Manzana con Mantequilla de Maní',
      'Nueces Mixtas',
      'Tortitas de Arroz',
      'Galletas Integrales',
      'Chips de Verduras',
      'Edamame',
      'Batido Verde',
      'Yogur con Frutas Frescas',
      'Crudités con Dip de Yogur',
      'Muffins de Avena',
      'Palomitas de Maíz',
      'Gelatina de Frutas',
      'Galletas de Avena',
      'Batido de Plátano'
    ],
    'Cena': [
      'Salmón a la Parrilla',
      'Tacos de Pollo',
      'Bistec con Ensalada',
      'Curry de Garbanzos',
      'Pizza de Verduras',
      'Enchiladas de Pollo',
      'Sopa Minestrone',
      'Brochetas de Camarones',
      'Pavo Asado con Batatas',
      'Ensalada de Espinacas y Fresas',
      'Curry de Pollo',
      'Ratatouille',
      'Pasta Primavera',
      'Sopa de Miso',
      'Pollo Teriyaki',
      'Albóndigas de Pavo',
      'Pimientos Rellenos',
      'Tarta de Espinacas',
      'Pollo a la Cazadora',
      'Sopa de Calabaza'
    ],
    'Snacks': [
      'Nueces Mixtas',
      'Palomitas de Maíz',
      'Galletas Integrales',
      'Queso con Galletas',
      'Chips de Verduras',
      'Barras de Frutas y Nueces',
      'Tortitas de Arroz con Aguacate',
      'Huevos Cocidos',
      'Chocolate Negro',
      'Batido',
      'Hummus con Chips de Pita',
      'Mix de Frutas Secas',
      'Palitos de Verdura con Hummus',
      'Rodajas de Manzana con Mantequilla de Almendra',
      'Requesón con Frutas',
      'Edamame',
      'Bolitas Energéticas',
      'Yogur Griego con Miel',
      'Palitos de Apio con Mantequilla de Maní'
    ]
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nutrición'),
          backgroundColor: Color(0xFFC0DEF4),
          automaticallyImplyLeading: false, // Desactiva la flecha de retroceso
        ),
        body: Container(
          color: Color(0xFFC0DEF4),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchTerm = value;
                    });
                    if (_searchTerm.isNotEmpty) {
                      _searchFood(_searchTerm);
                    } else {
                      _fetchRandomSuggestions();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar comidas...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FilterChip(
                        label: Text('Desayuno'),
                        selected: _selectedCategory == 'Desayuno',
                        selectedColor: Color(0xFF2A629A),
                        onSelected: (bool selected) {
                          if (selected) {
                            _searchFoodByCategory('Desayuno');
                          } else {
                            setState(() {
                              _selectedCategory = '';
                              _fetchRandomSuggestions();
                            });
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      FilterChip(
                        label: Text('Almuerzo'),
                        selected: _selectedCategory == 'Almuerzo',
                        selectedColor: Color(0xFF2A629A),
                        onSelected: (bool selected) {
                          if (selected) {
                            _searchFoodByCategory('Almuerzo');
                          } else {
                            setState(() {
                              _selectedCategory = '';
                              _fetchRandomSuggestions();
                            });
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      FilterChip(
                        label: Text('Cena'),
                        selected: _selectedCategory == 'Cena',
                        selectedColor: Color(0xFF2A629A),
                        onSelected: (bool selected) {
                          if (selected) {
                            _searchFoodByCategory('Cena');
                          } else {
                            setState(() {
                              _selectedCategory = '';
                              _fetchRandomSuggestions();
                            });
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      FilterChip(
                        label: Text('Merienda'),
                        selected: _selectedCategory == 'Merienda',
                        selectedColor: Color(0xFF2A629A),
                        onSelected: (bool selected) {
                          if (selected) {
                            _searchFoodByCategory('Merienda');
                          } else {
                            setState(() {
                              _selectedCategory = '';
                              _fetchRandomSuggestions();
                            });
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      FilterChip(
                        label: Text('Snacks'),
                        selected: _selectedCategory == 'Snacks',
                        selectedColor: Color(0xFF2A629A),
                        onSelected: (bool selected) {
                          if (selected) {
                            _searchFoodByCategory('Snacks');
                          } else {
                            setState(() {
                              _selectedCategory = '';
                              _fetchRandomSuggestions();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (_selectedCategory.isEmpty && _searchTerm.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sugerencias',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A629A),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _errorMessage.isNotEmpty
                            ? Center(child: Text(_errorMessage))
                            : _foods.isEmpty
                                ? Center(
                                    child: Text(
                                      'No se encontraron resultados',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black54),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: _foods.length,
                                    itemBuilder: (context, index) {
                                      final food = _foods[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0, 2),
                                                blurRadius: 6.0,
                                              ),
                                            ],
                                          ),
                                          child: ListTile(
                                            leading: food['image'] != null
                                                ? Image.network(food['image'],
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover)
                                                : null,
                                            title: Text(food['label']),
                                            subtitle: Text(
                                              'Calorías: ${food['nutrients']['ENERC_KCAL']?.toString() ?? 'N/A'} kcal',
                                            ),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
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
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text('Cerrar'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        _saveFood(food); // Save the food
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      child: const Text(
                                                          'Guardar'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
