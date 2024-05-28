import 'package:flutter/material.dart';
import 'package:glucare/screens/calendar_screen.dart';
import 'package:glucare/screens/comunity_screen.dart';
import 'package:glucare/screens/physical_activity_screen.dart';
import 'package:glucare/screens/profile_screen.dart';
import 'package:glucare/screens/nutrition_screen.dart';
import 'package:glucare/screens/reminder_list_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CommunityScreen(),
    ActividadFisicaScreen(),
    CalendarScreen(),
    NutritionScreen(),
    ReminderListScreen(),
    ProfileScreen(),
  ];

  static const List<Color> _backgroundColors = <Color>[
    Color(0xFFE3F2FD), // Color de fondo de Comunidad
    Color(0xFFE3F2FD), // Color de fondo de Actividad Física
    Color(0xFFE3F2FD), // Color de fondo de Calendario
    Color(0xFFE3F2FD), // Color de fondo de Nutrición
    Color(0xFFE3F2FD), // Color de fondo de Recordatorios
    Color(0xFFE3F2FD), // Color de fondo de Perfil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _backgroundColors[_selectedIndex], // Cambia el color de fondo según la pantalla seleccionada
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0), // Margen para flotación
        decoration: BoxDecoration(
          color: Color(0xFF2A629A), // Color de fondo especificado
          borderRadius: BorderRadius.circular(30.0), // Borde redondeado
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 2), // Sombra para flotación
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0), // Borde redondeado
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Comunidad',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Actividad Física',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendario',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: 'Nutricion',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm),
                label: 'Recordatorios',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.transparent, // Fondo transparente para mostrar el color del contenedor
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed, // Asegura que el fondo cubra todo
            showSelectedLabels: true, // Muestra los labels solo cuando están seleccionados
            showUnselectedLabels: false, // Oculta los labels cuando no están seleccionados
          ),
        ),
      ),
    );
  }
}
