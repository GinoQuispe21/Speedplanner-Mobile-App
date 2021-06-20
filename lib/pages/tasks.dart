import 'package:flutter/material.dart';
import 'package:speedplanner/Services/GetTasksByGroupId.dart';

import 'package:speedplanner/Services/getAllGroupsByCourseId.dart';
import 'package:speedplanner/models/CourseGroup.dart';
import 'package:speedplanner/models/Group.dart';
import 'package:speedplanner/models/GroupList.dart';
import 'package:speedplanner/utils/dateFooter.dart';

class Tasks extends StatefulWidget {
  final int id;
  final String token;

  const Tasks({this.id, this.token, Key key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  GetAllCoursesAndGroupsByUserIdService getGroups =
      new GetAllCoursesAndGroupsByUserIdService();
  GetAllTasksByGroupIdService getTasks = new GetAllTasksByGroupIdService();
  List<CourseGroup> listCoursesGroups = [];
  List<Group> listTasks = [];
  String formatter = '';

  void getCourseAndGroups() async {
    await getGroups.getAllCoursesAndGroupByUserId(widget.id, widget.token);
    setState(() {
      listCoursesGroups = getGroups.courses;
    });
    for (int i = 0; i < listCoursesGroups.length; i++) {
      print(
          "El curso $i : ${listCoursesGroups[i].id} - ${listCoursesGroups[i].name} - ${listCoursesGroups[i].description} - ${listCoursesGroups[i].email}- ${listCoursesGroups[i].color}");
      for (int j = 0; j < listCoursesGroups[i].listGroups.length; j++) {
        print(
            "El curso ${listCoursesGroups[i].name} posee el grupo ${listCoursesGroups[i].listGroups[j].id} ${listCoursesGroups[i].listGroups[j].name}");
      }
    }

    for (int i = 0; i < listCoursesGroups.length; i++) {
      for (int j = 0; j < listCoursesGroups[i].listGroups.length; j++) {
        await getTasks.getAllTasksByGroupId(
            listCoursesGroups[i].listGroups[j].id, widget.token);
        setState(() {
          listTasks = getTasks.groups;
        });
        for (int k = 0; k < listTasks.length; k++) {
          print(
              "El curso ${listCoursesGroups[i].name} posee ${listTasks[k].id} ${listTasks[k].name} ---> posee ${listTasks[k].listSimpleTasks.length}");
        }
      }
    }
  }

  void getGroupAndTasks() async {}

  @override
  void initState() {
    super.initState();
    // print('El id en Course es : ${widget.id}');
    // print('El token en Course es : ${widget.token}');
    // print('El nombre del usuario es : ${widget.username}');
    getCourseAndGroups();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: listCoursesGroups.isEmpty
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
                            child: ListView.builder(
                              itemCount: listCoursesGroups.length,
                              itemBuilder: (context, index) {
                                return taskCourse(listCoursesGroups[index]);
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

// Widget taskNumber(Group group){
//   return Text(

//   )
// }

Widget taskCourse(CourseGroup course) {
  int colorCard = int.parse(course.color);
  for (int i = 0; i < course.listGroups.length; i++) {}
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
                    '${course.name}\n',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
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
