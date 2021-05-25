import 'package:flutter/material.dart';
import 'package:speedplanner/pages/courses.dart';
import 'package:speedplanner/pages/groups.dart';
import 'package:speedplanner/pages/profile.dart';
import 'package:speedplanner/pages/tasks.dart';

class AddCourse extends StatefulWidget {
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  int _currentIndex = 0;

  final tabs = [Courses(), Tasks(), Groups(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speedplanner'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xff30B18B), Color(0xff8377d1)],
          )),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20, 10.0, 0),
                child: Text(
                  'Lina Montero',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  print("Nueva notificacion");
                },
                child: Icon(
                  Icons.notifications,
                  size: 26.0,
                  color: Colors.white,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                print("settings");
              },
              child: Icon(
                Icons.more_vert,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
          decoration: BoxDecoration(color: Color(0xff80C3B5)),
          child: Text('Add Course')),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xff8377D1), width: 3.0),
                top: BorderSide(color: Color(0xff8377D1), width: 0.3))),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xffE9EBF8),
          selectedItemColor: Color(0xff8377D1),
          unselectedItemColor: Color(0xff30B18B),
          selectedFontSize: 14,
          unselectedFontSize: 13,
          iconSize: 20,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.my_library_books_outlined),
                title: Text('Courses'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.create_outlined),
                title: Text('Task'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                title: Text('Groups'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                backgroundColor: Colors.blue),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
