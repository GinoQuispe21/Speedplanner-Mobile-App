import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/models/Course.dart';
import 'package:speedplanner/services/GetAllCourses.dart';
import 'package:speedplanner/utils/dateFooter.dart';

class Courses extends StatefulWidget {
  final int id;
  final String token;

  const Courses({this.id, this.token, Key key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  GetAllCoursesByUserIdService getCourses = new GetAllCoursesByUserIdService();
  List<Course> listCourse = [];
  String formatter = '';
  void getCurrentDate() async {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  void getCourse() async {
    await getCourses.getAllCoursesByUserId(widget.id, widget.token);
    setState(() {
      listCourse = getCourses.courses;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentDate();
    print('El id en Course es : ${widget.id}');
    print('El token en Course es : ${widget.token}');
    getCourse();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          heroTag: "btn1",
          backgroundColor: Color(0x00000000),
          elevation: 0,
          onPressed: () {
            Navigator.pushNamed(context, '/addCourse');
          },
          child: const Icon(
            Icons.add_circle,
            color: Color(0xff8377D1),
            size: 50.0,
          ),
        ),
      ),
      body: listCourse.isEmpty
          ? notCourses()
          : Container(
              height: size.height,
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xffE9EBF8)),
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                child: Text(
                              'Lista de Cursos',
                              style: TextStyle(fontSize: 18),
                            )),
                          ),
                          Container(
                            height: size.height / 1.57,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: listCourse.length,
                              itemBuilder: (context, index) {
                                return cardCourse(listCourse[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: dateFooter(
                          context: context, currentDate: 'Date: ' + formatter),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

Widget cardCourse(Course course) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(color: Color(0xff80C3B5)),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${course.name}'),
                Text('${course.description}'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget notCourses() {
  return Container(
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
  );
}
