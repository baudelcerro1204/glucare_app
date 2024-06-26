import 'package:flutter/material.dart';
import 'package:glucare/screens/login_screen.dart';
import 'package:glucare/widgets/bottom_navigation_bar.dart';
import 'package:glucare/widgets/custom_appbar.dart';
import 'package:glucare/screens/nutrition_screen.dart';
import 'package:glucare/screens/create_post_screen.dart';
import 'package:glucare/screens/comunity_screen.dart';
import 'package:glucare/screens/calendar_screen.dart';
import 'package:glucare/screens/day_details_screen.dart';
import 'package:glucare/screens/reminder_list_screen.dart';
import 'package:glucare/screens/new_reminder_screen.dart';
import 'package:glucare/screens/home_screen.dart'; // Importa la nueva pantalla

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glucare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const MainScreen(),
        '/create_post': (context) => const CreatePostScreen(),
        '/community': (context) => const CommunityScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/day_details': (context) =>
            DayDetailsScreen(date: DateTime.now()),
        '/login': (context) => IniciarSesion(
            correoElectronico:
                ''), // Agrega la ruta para la pantalla de registro
        '/reminders': (context) =>
            const ReminderListScreen(), // Agrega la ruta para la lista de recordatorios
        '/new_reminder': (context) =>
            NewReminderScreen(), // Agrega la ruta para la pantalla de nuevo recordatorio
        '/home': (context) =>
            const HomeScreen(), // Agrega la ruta para la pantalla de inicio
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: CustomBottomNavigationBar(), // Cambia el contenido para usar el BottomNavigationBar
    );
  }
}
