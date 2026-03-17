import 'package:flutter/material.dart';
import 'screens/grade_home_page.dart';

void main() {
  runApp(const StudentGradeCalculatorApp());
}

class StudentGradeCalculatorApp extends StatelessWidget {
  const StudentGradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Grade Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GradeHomePage(),
    );
  }
}