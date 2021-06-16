import 'package:flutter/material.dart';
import 'package:speedplanner/pages/courses.dart';
import 'package:speedplanner/pages/groups.dart';
import 'package:speedplanner/pages/profile.dart';
import 'package:speedplanner/pages/tasks.dart';
import 'package:speedplanner/utils/AppBar.dart';

class Home extends StatefulWidget {
  /*final int id;
  final String token;
  final String usernameData;

  Home(this.id, this.token, this.usernameData, {Key key}) : super(key: key);*/

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  Map data = {};
  //bool createCourse = false;
  @override
  void initState() {
    super.initState();
    /*print('El id en home es : ${widget.id}');
    print('El token en home es : ${widget.token}');
    print('El us    ernameData en home es : ${widget.usernameData}');*/
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    int id = data['id'];
    String token = data['token'];
    String name = data['usernameData'];

    print(data['id']);
    print(data['token']);
    print(data['usernameData']);
    final tabs = [
      //createCourse ? AddCourse() : Courses(),
      Courses(
        id: id,
        token: token,
        username: name,
      ),
      Tasks(),
      Groups(),
      Profile()
    ];

    return Scaffold(
      appBar: appBarSpeedplanner('$name'),
      body: tabs[_currentIndex],
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
                icon: Icon(Icons.my_library_books_outlined), label: 'Cursos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.create_outlined), label: 'Tareas'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Grupos'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
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
