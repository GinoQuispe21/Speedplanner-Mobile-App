import 'package:flutter/material.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: Color(0x00000000),
        elevation: 0,
        onPressed: () {
          Navigator.pushNamed(context, '/addCourse');
        },
        child: const Icon(
          Icons.add_circle_outline_sharp,
          color: Color(0xff8377D1),
          size: 50.0,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xffE9EBF8)),
        child: Center(
          child: Text(
            'Todavía no se han creado Cursos',
            style: TextStyle(
                color: Color(0xff9C9DA6),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}
