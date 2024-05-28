import 'package:flutter/material.dart';
import 'package:glucare/screens/calendar_screen.dart';
import 'package:glucare/screens/comunity_screen.dart';
import 'package:glucare/screens/home_screen.dart';
import 'package:glucare/screens/physical_activity_screen.dart';
import 'package:glucare/screens/profile_screen.dart';
import 'package:glucare/screens/nutrition_screen.dart';
import 'package:glucare/screens/reminder_list_screen.dart'; // Importamos la pantalla de lista de recordatorios

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
    CalendarScreen(),
    NutritionScreen(),
    ReminderListScreen(), // Añadimos la pantalla de lista de recordatorios
    ProfileScreen(), // Movemos la pantalla de perfil al final
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
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
