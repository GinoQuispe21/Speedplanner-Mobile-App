import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/Services/GetAllCourses.dart';

import 'package:speedplanner/Services/getAllGroupsByCourseId.dart';
import 'package:speedplanner/models/Course.dart';
import 'package:speedplanner/models/Group.dart';
import 'package:speedplanner/models/LisTasks.dart';
import 'package:speedplanner/models/STask.dart';
import 'package:speedplanner/models/TTask.dart';
import 'package:speedplanner/pages/taskDetails.dart';
import 'package:speedplanner/utils/dateFooter.dart';

class Tasks extends StatefulWidget {
  final int id;
  final String token;
  final String username;

  const Tasks({this.id, this.token, this.username, Key key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  GetAllCoursesByUserIdService getCourses = new GetAllCoursesByUserIdService();
  List<Course> listCourse = [];
  List<StudyGroup> listGroup = [];
  List<SimpleTask> listSimpleTask = [];
  List<TimedTask> listTimedTask = [];
  List<ListTask> listAllTasks = [];
  GroupsService groupsService = new GroupsService();
  String formatter = '';

  var countTasks = [];
  var courseCount = [];
  var cont = 0;
  var aux = 0;

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
    for (int i = 0; i < listCourse.length; i++) {
      courseCount.add(listCourse[i].id);
      print(
          "El curso $i : ${listCourse[i].id} - ${listCourse[i].name} - ${listCourse[i].description} - ${listCourse[i].email}- ${listCourse[i].color}");
      print("Tamaño de la lista de tiempos: ${listCourse[i].listTimes.length}");
      print("Lista de fechas del curso:");
    }
    print(courseCount);

    for (int i = 0; i < courseCount.length; i++) {
      cont = 0;
      aux = listAllTasks.length;
      await groupsService.getAllGroupsByCourseId(courseCount[i], widget.token);
      setState(() {
        listGroup = groupsService.studyGroupList;
        listSimpleTask = groupsService.simpleTaskList;
        listTimedTask = groupsService.timedTaskList;
        listAllTasks = groupsService.listAllTasks;
      });
      print("Lista de grupos");
      for (int i = 0; i < listGroup.length; i++) {
        print(
            '${listGroup[i].id} - ${listGroup[i].name} - ${listGroup[i].descrpiton}');
      }
      for (int j = 0; j < listAllTasks.length; j++) {
        cont++;
      }
      countTasks.add(cont - aux);
    }
    print(countTasks);
  }

  void getGroupAndTasks() async {}

  @override
  void initState() {
    super.initState();
    getCurrentDate();
    // print('El id en Course es : ${widget.id}');
    // print('El token en Course es : ${widget.token}');
    // print('El nombre del usuario es : ${widget.username}');
    //getCourseAndGroups();
    getCourse();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: listCourse.isEmpty
          ? notTask()
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
                              'Lista de Tareas',
                              style: TextStyle(fontSize: 18),
                            )),
                          ),
                          Container(
                              height: size.height / 1.57,
                              width: double.infinity,
                              child: listCourse.length == countTasks.length
                                  ? ListView.builder(
                                      itemCount: listCourse.length,
                                      itemBuilder: (context, index) {
                                        return taskCourse(
                                            listCourse[index],
                                            countTasks[index],
                                            context,
                                            widget.token,
                                            widget.id,
                                            widget.username);
                                      },
                                    )
                                  : Text("esperando data")),
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

// Widget taskNumber(Group group){
//   return Text(

//   )
// }

Widget taskCourse(
    Course course, int task, context, String token, int id, String uName) {
  int colorCard = int.parse(course.color);
  return Container(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Card(
        child: Container(
            decoration: BoxDecoration(color: Color(colorCard)),
            child: Padding(
              //padding: const EdgeInsets.all(36.0),
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5),
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
                  Text(
                    'Total de Tareas por realizar: ${task}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 65, top: 10, bottom: 10),
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskDetails(
                                          id: id,
                                          courseId: course.id,
                                          token: token,
                                          username: uName,
                                        )),
                              );
                              // Navigator.pushNamed(context, '/taskDetails',
                              //     arguments: {
                              //       'id': id,
                              //       'token': token,
                              //       'username': uName,
                              //       'courseId': course.id,
                              //     });
                            },
                            child: Text(
                              'Ver Tareas',
                              style: TextStyle(
                                  color: Color(colorCard),
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    ),
  );
}

Widget notTask() {
  return Container(
    decoration: BoxDecoration(color: Color(0xffE9EBF8)),
    child: Center(
      child: Text(
        'Todavía no se han creado Tareas',
        style: TextStyle(
            color: Color(0xff9C9DA6),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
    ),
  );
}
