import 'package:flutter/material.dart';
import 'package:gwa_calculator/home.dart'; // Make sure this path is correct

void main() => runApp(const GPACalculatorApp());

class GPACalculatorApp extends StatelessWidget {
  const GPACalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins', // Set the default font for the whole app
        textTheme: const TextTheme(
          bodyText1: TextStyle(), // Default style for body text
          bodyText2: TextStyle(), // Default style for other text
          // Add other styles if needed
        ),
      ),
      home: const Home(),
    );
  }
}


class Course {
  String id = UniqueKey().toString();
  double numericalRating = 0.0;
  double units = 0.0;
}

typedef OnRemoved = void Function();