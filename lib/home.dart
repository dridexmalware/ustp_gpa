import 'package:flutter/material.dart';
import 'package:gwa_calculator/main.dart';
import 'package:gwa_calculator/input.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Course> courses = [];

  void _addCourse() {
    setState(() {
      courses.add(Course());
    });
  }

  void _removeCourse(int index) {
    setState(() {
      courses.removeAt(index);
    });
  }

  double _calculateTotalUnits() {
    return courses.fold(0.0, (sum, course) => sum + course.units);
  }

  double _calculateTotalGradePoints() {
    return courses.fold(0.0, (total, course) => total + (course.numericalRating * course.units));
  }

  double _calculateGPA() {
    double totalUnits = _calculateTotalUnits();
    double totalPoints = _calculateTotalGradePoints();
    return totalUnits > 0 ? totalPoints / totalUnits : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (courses.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Image.asset('assets/ustp.png', height: 150),
                  ),
                ...courses.map((course) {
                  int index = courses.indexOf(course);
                  return CourseInput(
                    key: ValueKey(course.id),
                    course: course,
                    onRemoved: () => _removeCourse(index),
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: _addCourse,
                    child: const Text('Add Course', style: TextStyle(color: Color(0xFF1A1751))),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Color(0xFF1A1751),
                      side: BorderSide(color: Color(0xFF1A1751), width: 1),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                if (courses.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () => setState(() {}),
                      child: const Text('Calculate'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1A1751),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                if (courses.isNotEmpty) ...[
                  Text('Units Total: ${_calculateTotalUnits().toStringAsFixed(2)}'),
                  Text('Total Grade Points: ${_calculateTotalGradePoints().toStringAsFixed(2)}'),
                  Text('Your GPA: ${_calculateGPA().toStringAsFixed(2)}'),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
