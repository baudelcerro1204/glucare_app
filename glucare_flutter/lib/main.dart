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
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/create_post': (context) => const CreatePostScreen(),
        '/community': (context) => const CommunityScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/day_details': (context) =>
            DayDetailsScreen(date: DateTime.now()), // Placeholder
        '/nutrition': (context) =>
            const NutritionScreen(), // Agrega la nueva ruta para la pantalla de nutrición
        '/login': (context) =>
            IniciarSesion(), // Agrega la ruta para la pantalla de registro
        '/reminders': (context) =>
            const ReminderListScreen(), // Agrega la ruta para la lista de recordatorios
        '/new_reminder': (context) =>
            NewReminderScreen(), // Agrega la ruta para la pantalla de nuevo recordatorio
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
      body: Column(
        children: [
          Expanded(
            child: CustomBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
