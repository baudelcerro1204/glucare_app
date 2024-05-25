import 'package:flutter/material.dart';
import 'package:glucare/screens/comunity_screen.dart';
import 'package:glucare/screens/home_screen.dart';
import 'package:glucare/screens/physical_activity_screen.dart';
import 'package:glucare/screens/profile_screen.dart';
import 'package:glucare/screens/nutrition_screen.dart'; // Importamos la pantalla de nutrición

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CommunityScreen(),
    ActividadFisicaScreen(),
    NutritionScreen(), // Añadimos la pantalla de nutrición
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Actividad Física',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood), // Icono para la pantalla de nutrición
            label: 'Nutrition', // Etiqueta para la pantalla de nutrición
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black, // Color de los ítems no seleccionados
        onTap: _onItemTapped,
      ),
    );
  }
}

