import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:glucare/model/GlucoseMeasurement.dart';
import 'package:glucare/model/MonthlyAverage.dart';
import 'package:glucare/model/WeeklyAverage.dart';
import 'package:glucare/screens/information_screen.dart';
import 'package:glucare/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:collection';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _messages = [];
  int _currentMessageIndex = 0;
  Map<String, double> _dailyAverages = {};
  Map<String, WeeklyAverage> _weeklyAverages = {};
  Map<String, MonthlyAverage> _monthlyAverages = {};
  List<GlucoseMeasurement> _glucoseHistory = [];
  Map<DateTime, double> _dailyAverageMap = {};
  bool _showWelcomeMessage = true;
  String _welcomeMessage = '';
  bool _hasGlucoseMeasurementsToday = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchDailyAverages();
    _fetchWeeklyAverages();
    _fetchMonthlyAverages();
    _fetchGlucoseHistory();
    _checkGlucoseMeasurements();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('user_name') ?? 'Usuario';
    final firstLogin = prefs.getBool('first_login') ?? true;

    setState(() {
      if (firstLogin) {
        _welcomeMessage = '¡Hola $userName! Qué bueno verte de nuevo.';
        prefs.setBool('first_login', false);
      } else {
        _showWelcomeMessage = false;
      }
    });
  }

  final apiService = ApiService('http://192.168.0.136:8080');

  Future<void> _fetchDailyAverages() async {
    try {
      final averages = await apiService.getDailyAverageGlucose();
      setState(() {
        _dailyAverages = averages;
        _calculateDailyAverages();
      });
    } catch (e) {
      print('Error al obtener los promedios diarios: $e');
    }
  }

  Future<void> _fetchWeeklyAverages() async {
    try {
      final averages = await apiService.getWeeklyAverageGlucose();
      setState(() {
        _weeklyAverages = averages;
      });
    } catch (e) {
      print('Error al obtener los promedios semanales: $e');
    }
  }

  Future<void> _fetchMonthlyAverages() async {
    try {
      final averages = await apiService.getMonthlyAverageGlucose();
      setState(() {
        _monthlyAverages = averages;
      });
    } catch (e) {
      print('Error al obtener los promedios mensuales: $e');
    }
  }

  Future<void> _fetchGlucoseHistory() async {
    try {
      final history = await apiService.getGlucoseHistory();
      setState(() {
        _glucoseHistory = history;
        _calculateDailyAverages();
      });
    } catch (e) {
      print('Error al obtener el historial de glucosa: $e');
    }
  }

  Future<void> _checkGlucoseMeasurements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId == null) {
        print('User ID not found');
        return;
      }

      final measurements = await apiService.getGlucoseMeasurementsByDate(DateTime.now());
      setState(() {
        _hasGlucoseMeasurementsToday = measurements.isNotEmpty;
        if (_hasGlucoseMeasurementsToday) {
          _fetchMotivationalMessage();
        } else {
          _messages.add('No cargaste mediciones de glucosa hoy.');
        }
      });
    } catch (e) {
      print('Error al verificar las mediciones de glucosa: $e');
    }
  }

  Future<void> _fetchMotivationalMessage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId == null) {
        print('User ID not found');
        return;
      }

      final message = await apiService.getMotivationalMessage(userId);
      setState(() {
        _messages.add(message);
      });
    } catch (e) {
      print('Error al obtener mensaje motivacional: $e');
    }
  }

  void _calculateDailyAverages() {
    if (_glucoseHistory.isEmpty) return;

    Map<DateTime, List<double>> dailyValues = {};

    for (var measurement in _glucoseHistory) {
      final date = DateTime(measurement.date.year, measurement.date.month, measurement.date.day);
      if (!dailyValues.containsKey(date)) {
        dailyValues[date] = [];
      }
      dailyValues[date]!.add(measurement.value);
    }

    setState(() {
      _dailyAverageMap = dailyValues.map((date, values) => MapEntry(
          date, values.reduce((a, b) => a + b) / values.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC0DEF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC0DEF4),
        leading: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InformationScreen()),
            );
          },
        ),
        title: const Text('Inicio'),
      ),
      body: ListView(
        children: [
          if (_showWelcomeMessage)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomPaint(
                painter: MessageBubblePainter(),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _welcomeMessage,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          if (!_showWelcomeMessage && _messages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomPaint(
                painter: MessageBubblePainter(),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _messages.last,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          Image.asset(
            _showWelcomeMessage
                ? 'lib/assets/glucare_panda_saludando.png'
                : _hasGlucoseMeasurementsToday
                    ? 'lib/assets/glucare_panda_feliz.png'
                    : 'lib/assets/glucare_panda_triste.png',
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _dailyAverageMap.isNotEmpty
                      ? SizedBox(
                          height: 300,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceBetween,
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(
                                          '${date.day}/${date.month}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 20,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(
                                show: true,
                                border: Border.all(color: Colors.black26),
                              ),
                              barGroups: _dailyAverageMap.entries
                                  .map((entry) => BarChartGroupData(
                                        x: entry.key.millisecondsSinceEpoch.toInt(),
                                        barRods: [
                                          BarChartRodData(
                                            toY: entry.value,
                                            color: Colors.blue,
                                            width: 15,
                                          ),
                                        ],
                                      ))
                                  .toList(),
                            ),
                          ),
                        )
                      : const Text('Cargando historial de glucosa...'),
                  const SizedBox(height: 20),
                  _buildAverageSection('Promedio Diario', _dailyAverages),
                  _buildWeeklyAverageSection('Promedio Semanal', _weeklyAverages),
                  _buildMonthlyAverageSection('Promedio Mensual', _monthlyAverages),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAverageSection(String title, Map<String, double> averages) {
    return averages.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...averages.entries.map((entry) => Text(
                    '${entry.key}: ${entry.value.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 20),
            ],
          )
        : Text('Cargando $title...');
  }

  Widget _buildWeeklyAverageSection(String title, Map<String, WeeklyAverage> averages) {
    return averages.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...averages.entries.map((entry) => Text(
                    '${entry.key}: ${entry.value.averageValue.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 20),
            ],
          )
        : Text('Cargando $title...');
  }

  Widget _buildMonthlyAverageSection(String title, Map<String, MonthlyAverage> averages) {
    return averages.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...averages.entries.map((entry) => Text(
                    '${entry.key}: ${entry.value.averageValue.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 20),
            ],
          )
        : Text('Cargando $title...');
  }
}

class MessageBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path()
      ..moveTo(20, 0)
      ..lineTo(size.width - 20, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 20)
      ..lineTo(size.width, size.height - 20)
      ..quadraticBezierTo(size.width, size.height, size.width - 20, size.height)
      ..lineTo(size.width / 2 + 20, size.height)
      ..lineTo(size.width / 2, size.height + 20)
      ..lineTo(size.width / 2 - 20, size.height)
      ..lineTo(20, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - 20)
      ..lineTo(0, 20)
      ..quadraticBezierTo(0, 0, 20, 0);

    canvas.drawPath(path, paint);

    // Fill the background with white color
    final backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, backgroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
