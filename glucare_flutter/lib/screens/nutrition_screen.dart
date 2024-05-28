import 'package:flutter/material.dart';
import 'package:glucare/services/api_service.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final ApiService apiService = ApiService('https://api.edamam.com');
  final TextEditingController _searchController = TextEditingController();
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
        title: Text('Nutrición'),
        backgroundColor: Color(0xFFE3F2FD),
      ),
      body: Container(
        color: Color(0xFFE3F2FD),
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
                    setState(() {
                      _foods = [];
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Ingrese Alimento...',
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
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage.isNotEmpty
                      ? Center(child: Text(_errorMessage))
                      : _foods.isEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  final defaultFoods = ['Carbohidratos', 'Proteínas', 'Grasas'];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(0, 2),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Center(
                                          child: Text(
                                            defaultFoods[index],
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
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
                            ),
            ],
          ),
        ),
      ),
    );
  }
}
