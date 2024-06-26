import 'package:flutter/material.dart';
import 'package:glucare/screens/calendar_screen.dart';
import 'package:glucare/screens/comunity_screen.dart';
//import 'package:glucare/screens/physical_activity_screen.dart';
import 'package:glucare/screens/profile_screen.dart';
//import 'package:glucare/screens/nutrition_screen.dart';
import 'package:glucare/screens/reminder_list_screen.dart';
import 'package:glucare/screens/home_screen.dart'; // Importa la pantalla Home

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 2; // Inicializamos con la "Home" seleccionada en el medio

  static const List<Widget> _widgetOptions = <Widget>[
    CommunityScreen(),
    CalendarScreen(),
    HomeScreen(), // Home en el medio
    ReminderListScreen(),
    ProfileScreen(),
  ];

  static const List<Color> _backgroundColors = <Color>[
    Color(0xFFC0DEF4), // Color de fondo de Comunidad
    Color(0xFFC0DEF4), // Color de fondo de Calendario
    Color(0xFFC0DEF4), // Color de fondo de Home
    Color(0xFFC0DEF4), // Color de fondo de Recordatorios
    Color(0xFFC0DEF4), // Color de fondo de Perfil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColors[
          _selectedIndex], // Establece el color de fondo del Scaffold
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            bottom: 10.0, left: 10.0, right: 10.0), // Margen para flotación
        decoration: BoxDecoration(
          color: Color(0xFF0E245D), // Color de fondo especificado
          borderRadius: BorderRadius.circular(30.0), // Borde redondeado
          boxShadow: [
            BoxShadow(
              color: Colors.white,
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
                icon: Icon(Icons.calendar_today), // Icono de Calendario
                label: 'Calendario', // Calendario ahora ocupa el lugar de Nutrición
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home), // Icono de Home
                label: 'Home', // Etiqueta de Home
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.alarm),
                label: 'Recordatorios',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
              //BottomNavigationBarItem(
                //icon: Icon(Icons.fitness_center),
                //label: 'Actividad Física',
              //),
              //BottomNavigationBarItem(
                //icon: Icon(Icons.fastfood), // Icono de Nutrición
                //label: 'Nutrición', // Nutrición ahora ocupa el lugar de Calendario
              //),
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