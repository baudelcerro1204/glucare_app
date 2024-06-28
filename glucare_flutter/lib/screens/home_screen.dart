import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:glucare/model/GlucoseMeasurement.dart';
import 'package:glucare/model/MonthlyAverage.dart';
import 'package:glucare/model/WeeklyAverage.dart';
import 'package:glucare/screens/information_screen.dart';
import 'package:glucare/services/api_service.dart';
import 'dart:async';
import 'dart:collection';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _messages = [
    '¡Hola! user_id, ¿cómo te encuentras hoy?',
    'Recuerda beber agua y mantenerte hidratado.',
    '¡Vamos a hacer algo de ejercicio hoy!',
    '¡Eres increíble, sigue así!',
    'No olvides comer tus frutas y verduras.',
  ];
  int _currentMessageIndex = 0;
  late Timer _timer;
  Map<String, double> _dailyAverages = {};
  Map<String, WeeklyAverage> _weeklyAverages = {};
  Map<String, MonthlyAverage> _monthlyAverages = {};
  List<GlucoseMeasurement> _glucoseHistory = [];
  Map<DateTime, double> _dailyAverageMap = {};

  @override
  void initState() {
    super.initState();
    _startMessageRotation();
    _fetchDailyAverages();
    _fetchWeeklyAverages();
    _fetchMonthlyAverages();
    _fetchGlucoseHistory();
  }

  void _startMessageRotation() {
    _timer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      setState(() {
        _currentMessageIndex = (_currentMessageIndex + 1) % _messages.length;
      });
    });
  }

  final apiService = ApiService('http://192.168.0.5:8080');

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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
      backgroundColor: Color(0xFFC0DEF4),
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
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                _messages[_currentMessageIndex],
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Image.asset(
            'lib/assets/glucare_panda_saludando.png', // Cambia esto a la ruta de tu imagen
            height: 200, // Ajusta el tamaño según sea necesario
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
                    offset: Offset(0, 2),
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
                                          style: TextStyle(
                                            fontSize: 12, // Agrandar las fechas
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
                                        style: TextStyle(
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
                      : Text('Cargando historial de glucosa...'),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...averages.entries.map((entry) => Text(
                    '${entry.key}: ${entry.value.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...averages.entries.map((entry) => Text(
                    '${entry.key}: ${entry.value.averageValue.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ...averages.entries.map((entry) => Text(
                    '${entry.key}: ${entry.value.averageValue.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 20),
            ],
          )
        : Text('Cargando $title...');
  }
}
