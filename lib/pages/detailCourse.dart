import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:speedplanner/models/Course.dart';
import 'package:speedplanner/models/ListTask.dart';
import 'package:speedplanner/models/SimpleTask.dart';
import 'package:speedplanner/models/StudyGroup.dart';
import 'package:speedplanner/models/TimedTask.dart';
import 'package:speedplanner/pages/createSimpleTask.dart';
import 'package:speedplanner/pages/createTimedTask.dart';
import 'package:speedplanner/services/GetAllGroupsByCourseId.dart';
import 'package:speedplanner/services/GetSimpleTaskById.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailCourse extends StatefulWidget {
  final Course course;
  final String token;
  final String username;
  const DetailCourse({this.course, this.token, this.username, key})
      : super(key: key);

  @override
  _DetailCourseState createState() => _DetailCourseState();
}

class _DetailCourseState extends State<DetailCourse> {
  String formatter = '';
  double titleSize = 23.0;
  List<StudyGroup> listGroup = [];
  List<SimpleTask> listSimpleTask = [];
  List<TimedTask> listTimedTask = [];
  List<ListTask> listAllTasks = [];
  GroupsService groupsService = new GroupsService();
  SimpleTaskService simpleTaskService = new SimpleTaskService();

  _openPopup(context) {
    Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: Color(0xffE9EBF8),
        ),
        title: "Tipo de Tarea",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton.icon(
              icon: Icon(
                Icons.adjust,
                color: purpleColor,
                size: 24.0,
              ),
              label: Text(
                'Crear Tarea Simple',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateSimpleTask(
                              token: widget.token,
                              username: widget.username,
                              listGroup: listGroup,
                            )));
              },
              style: ElevatedButton.styleFrom(
                  primary: Color(0x00000000), shadowColor: Color(0x000000)),
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.adjust,
                color: greenColor,
                size: 24.0,
              ),
              label: Text(
                'Crear Tarea Cronometrada',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateTimedTask(
                              token: widget.token,
                              username: widget.username,
                              listGroup: listGroup,
                            )));
              },
              style: ElevatedButton.styleFrom(
                  primary: Color(0x00000000), shadowColor: Color(0x000000)),
            ),
          ],
        ),
        buttons: []).show();
  }

  void getCurrentDate() async {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  void getGroups() async {
    await groupsService.getAllGroupsByCourseId(widget.course.id, widget.token);
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
  }

  @override
  void initState() {
    super.initState();
    getCurrentDate();
    getGroups();
    //getSimpleTasks();
    print(widget.course.name.length);
    if (widget.course.name.length > 30) {
      titleSize = 18.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int colorCard = int.parse(widget.course.color);
    return Scaffold(
      floatingActionButton: listGroup.length == 0
          ? null
          : Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text("Crear Tarea"),
                    ),
                    FloatingActionButton(
                      heroTag: "btn3",
                      backgroundColor: Color(0x00000000),
                      elevation: 0,
                      onPressed: () {
                        _openPopup(context);
                      },
                      child: const Icon(
                        Icons.add_circle_outline_sharp,
                        color: Color(0xff80C3B5),
                        size: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      appBar: appBarSpeedplanner('${widget.username}'),
      body: listGroup.length == 0
          ? Container(
              decoration: BoxDecoration(color: backgroundColor),
              height: size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Center(
                        child: SpinKitFadingCircle(
                      color: purpleColor,
                      size: 50,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Cargando detalle del curso',
                      style: TextStyle(color: purpleColor),
                    ),
                  )
                ],
              ))
          : Container(
              height: size.height,
              width: double.infinity,
              decoration: BoxDecoration(color: backgroundColor),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                      top: 20,
                      child: Container(
                          width: size.width,
                          height: size.height / 13,
                          decoration: BoxDecoration(color: Color(colorCard)),
                          child: Center(
                            child: Text(
                              "${widget.course.name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: titleSize,
                              ),
                            ),
                          ))),
                  Positioned(
                    bottom: 10,
                    child: Container(
                        height: size.height / 1.4,
                        width: size.width / 1.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Decripción",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              '${widget.course.description}',
                              style: TextStyle(),
                            ),
                            Divider(
                              height: 20.0,
                              thickness: 1.5,
                              color: Color(0Xff707070),
                            ),
                            Text(
                              "Correo del Docente",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              '${widget.course.email}',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Divider(
                              height: 20.0,
                              thickness: 1.5,
                              color: Color(0Xff707070),
                            ),
                            Text(
                              "Horario de clase",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Container(
                              height: 23.0 * (widget.course.listTimes.length),
                              width: 200,
                              child: ListView.builder(
                                  itemCount: widget.course.listTimes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text(
                                        '- ${widget.course.listTimes[index].day} -> ${widget.course.listTimes[index].starterTime} - ${widget.course.listTimes[index].finishTime}');
                                  }),
                            ),
                            Divider(
                              height: 20.0,
                              thickness: 1.5,
                              color: Color(0Xff707070),
                            ),
                            Text(
                              "Grupos",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Container(
                              height: listGroup.length * 22.0,
                              child: ListView.builder(
                                itemCount: listGroup.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text('- ${listGroup[index].name}');
                                  //Text('- ${listGroup[index].name}');
                                },
                              ),
                            ),
                            Divider(
                              height: 20.0,
                              thickness: 1.5,
                              color: Color(0Xff707070),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Tareas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('${listAllTasks.length} por realizar',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: listAllTasks.length == 0
                                  ? Center(
                                      child:
                                          Text("No se han programado tareas"),
                                    )
                                  : Container(
                                      height: listAllTasks.length * 30.0,
                                      child: ListView.builder(
                                          itemCount: listAllTasks.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    child: IconButton(
                                                      padding:
                                                          new EdgeInsets.all(
                                                              0.0),
                                                      icon: Icon(listAllTasks[
                                                                  index]
                                                              .finished
                                                          ? Icons.check_box
                                                          : Icons
                                                              .check_box_outline_blank),
                                                      //.check_box_outline_blank,
                                                      //Icons.check_box,
                                                      onPressed: () {
                                                        setState(() {
                                                          listAllTasks[index]
                                                                  .finished =
                                                              !listAllTasks[
                                                                      index]
                                                                  .finished;
                                                          print(listAllTasks[
                                                                  index]
                                                              .id);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    child: Text(
                                                      "${listAllTasks[index].title} ${listAllTasks[index].type}",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 25,
                                                    width: 25,
                                                    child: IconButton(
                                                        padding:
                                                            new EdgeInsets.all(
                                                                0.0),
                                                        icon: Icon(
                                                          Icons.edit_sharp,
                                                          size: 20,
                                                        ),
                                                        onPressed: () {}),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                            )
                          ],
                        )),
                  ),
                  Positioned(
                      bottom: 0,
                      child: dateFooter(
                          context: context, currentDate: 'Date: ' + formatter))
                ],
              ),
            ),
    );
  }
}
