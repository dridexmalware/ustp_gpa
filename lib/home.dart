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

  Color _getBackgroundColor(double gpa) {
    if (gpa >= 3.01) {
      return Colors.red;
    } else if (gpa < 1.76) {
      return Colors.green;
    } else if (gpa < 3.01) {
      return Colors.orange;
    } else {
      return Colors.blue; // Default color if none of the conditions are met
    }
  }

  @override
  Widget build(BuildContext context) {
    double gpa = courses.isNotEmpty ? _calculateGPA() : 0.0;
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
                    child: Text('Add Course', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Color(0xFF1A1751),
                      side: BorderSide(color: Color(0xFF1A1751), width: 1),
                      minimumSize: Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                if (courses.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () => setState(() {}),
                      child: Text('Calculate', style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF1A1751),
                        minimumSize: Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: courses.isNotEmpty ? _getBackgroundColor(gpa) : Colors.blue,
        child: Container(
          height: 50.0,
          child: Center(
            child: courses.isNotEmpty ? Text(
              'Your GPA: ${gpa.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ) : SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
