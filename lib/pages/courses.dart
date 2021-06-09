import 'package:flutter/material.dart';
import 'package:speedplanner/models/Course.dart';
import 'package:speedplanner/services/GetAllCourses.dart';

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

  void getCourse() async {
    await getCourses.getAllCoursesByUserId(widget.id, widget.token);
    setState(() {
      listCourse = getCourses.courses;
    });
  }

  @override
  void initState() {
    super.initState();
    print('El id en Course es : ${widget.id}');
    print('El token en Course es : ${widget.token}');
    getCourse();
  }

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
        body: listCourse.isEmpty
            ? notCourses()
            : Container(
                decoration: BoxDecoration(color: Color(0xffE9EBF8)),
                child: ListView.builder(
                  itemCount: listCourse.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                            listCourse[index].name,
                          ),
                          subtitle: Text(
                            listCourse[index].description,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
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
