import 'package:flutter/material.dart';
import 'package:gwa_calculator/splash_screen.dart';

void main() => runApp(const GPACalculatorApp());

class GPACalculatorApp extends StatelessWidget {
  const GPACalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}

class Course {
  String id = UniqueKey().toString();
  double numericalRating = 0.0;
  double units = 0.0;
}

typedef OnRemoved = void Function();