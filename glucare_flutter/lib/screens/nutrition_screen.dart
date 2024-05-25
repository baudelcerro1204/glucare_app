import 'package:flutter/material.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  String _searchTerm = '';
  String _selectedFilter = 'All'; // Inicialmente, muestra todos los alimentos
  List<String> _foods = []; // Lista de alimentos obtenidos de la API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchTerm = value;
              // Aquí deberías realizar la búsqueda en la API y actualizar _foods con los resultados
            });
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
                child: Text('Fats'),
              ),
            ],
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
                // Aquí deberías filtrar los alimentos basados en el valor seleccionado
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
