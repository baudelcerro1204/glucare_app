import 'package:flutter/material.dart';

class InformationDetailsScreen extends StatelessWidget {
  final String title;
  final String content;

  const InformationDetailsScreen(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFFC0DEF4),
      ),
      body: Container(
        color: Color(0xFFC0DEF4),
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
