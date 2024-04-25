import 'package:flutter/material.dart';

void main() => runApp(GPACalculatorApp());

class GPACalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GPACalculatorPage(),
    );
  }
}

class GPACalculatorPage extends StatefulWidget {
  @override
  _GPACalculatorPageState createState() => _GPACalculatorPageState();
}

class _GPACalculatorPageState extends State<GPACalculatorPage> {
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
    return courses.fold(0.0, (sum, course) => sum + (course.numericalRating * course.units));
  }

  double _calculateGPA() {
    double totalUnits = _calculateTotalUnits();
    return totalUnits > 0 ? _calculateTotalGradePoints() / totalUnits : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GPA Calculator')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ...courses.map((course) {
              int index = courses.indexOf(course);
              return CourseInput(
                key: ValueKey(course.id),
                course: course,
                onRemoved: () => _removeCourse(index),
              );
            }).toList(),
            ElevatedButton(
              onPressed: _addCourse,
              child: Text('Add Course'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {}); // Trigger re-calculation
              },
              child: Text('Calculate'),
            ),
            if (courses.isNotEmpty) ...[
              Text('Units Total: ${_calculateTotalUnits().toStringAsFixed(2)}'),
              Text('Total Grade Points: ${_calculateTotalGradePoints().toStringAsFixed(2)}'),
              Text('Your GPA: ${_calculateGPA().toStringAsFixed(2)}'),
            ]
          ],
        ),
      ),
    );
  }
}

class Course {
  String id = UniqueKey().toString();
  double numericalRating = 0.0;
  double units = 0.0;
}

typedef OnRemoved = void Function();

class CourseInput extends StatefulWidget {
  final Course course;
  final OnRemoved onRemoved;

  CourseInput({Key? key, required this.course, required this.onRemoved}) : super(key: key);


  @override
  _CourseInputState createState() => _CourseInputState();
}

class _CourseInputState extends State<CourseInput> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Subject Code'),
              onChanged: (value) => setState(() {}),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Numerical Rating'),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      setState(() {
                        widget.course.numericalRating = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Academic Units'),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      setState(() {
                        widget.course.units = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: widget.onRemoved,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
