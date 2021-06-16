import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/models/Course.dart';
import 'package:speedplanner/models/Time.dart';
//?import 'package:speedplanner/models/Time.dart';
import 'package:speedplanner/services/GetAllCourses.dart';
//?import 'package:speedplanner/services/GetAllTimesByCourseId.dart';
import 'package:speedplanner/utils/dateFooter.dart';

class Courses extends StatefulWidget {
  final int id;
  final String token;
  final String username;

  const Courses({this.id, this.token, this.username, Key key})
      : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  GetAllCoursesByUserIdService getCourses = new GetAllCoursesByUserIdService();
  List<Course> listCourse = [];
  String formatter = '';

  //*Data creada solo para ejemplo de fechas

  List<Time> listTime = [];

  //!Llamada al servicio de get all times by course Id
  /*GetAllTimesByUserIdService getAllTimesByUserIdService =
      new GetAllTimesByUserIdService();
  List<Time> listTime = [];

  void getTimes(int id, String token) async {
    await getAllTimesByUserIdService.getAllTimesByUserId(id, token);
    setState(() {
      listTime = getAllTimesByUserIdService.listTime;
    });
  }*/

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
    print('El nombre del usuario es : ${widget.username}');
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
            Navigator.pushNamed(context, '/addCourse', arguments: {
              'id': widget.id,
              'token': widget.token,
              'username': widget.username
            });
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
                                return cardCourse(listCourse[index], listTime);
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

Widget cardCourse(Course course, List<Time> listTime) {
  int colorCard = int.parse(course.color);

  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(color: Color(colorCard)),
          child: Padding(
            //padding: const EdgeInsets.all(36.0),
            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${course.name}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  child: Text(
                    '${course.description}',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Lunes -> 09:00 - 11:00",
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Container(
                          height: 33,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: TextButton(
                              style: TextButton.styleFrom(),
                              onPressed: () {},
                              child: Text(
                                'Ver Detalles',
                                style: TextStyle(
                                    color: Color(colorCard),
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
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
