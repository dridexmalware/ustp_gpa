import 'package:flutter/material.dart';
import '../main.dart';

class CourseInput extends StatefulWidget {
  final Course course;
  final OnRemoved onRemoved;

  const CourseInput({Key? key, required this.course, required this.onRemoved}) : super(key: key);


  @override
  _CourseInputState createState() => _CourseInputState();
}

class _CourseInputState extends State<CourseInput> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Subject Code'),
              onChanged: (value) => setState(() {}),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Numerical Rating'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      setState(() {
                        widget.course.numericalRating = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Academic Units'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      setState(() {
                        widget.course.units = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
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