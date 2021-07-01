import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speedplanner/models/HardModels/Group.dart';
import 'package:speedplanner/models/HardModels/GroupAndSTask.dart';
import 'package:speedplanner/models/HardModels/GroupAndTTasks.dart';
import 'package:speedplanner/models/HardModels/LisTasks.dart';
import 'package:speedplanner/models/HardModels/STask.dart';
import 'package:speedplanner/models/HardModels/TTask.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/Services/getAllTasksByUserId.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:speedplanner/utils/dateFooter.dart';

class TaskDetails extends StatefulWidget {
  final int id;
  final String token;
  final String username;
  final int courseId;
  final String courseName;
  final Color courseColor;
  final int conditional;

  const TaskDetails(
      {this.id,
      this.token,
      this.username,
      this.courseId,
      this.courseName,
      this.courseColor,
      this.conditional,
      key})
      : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List<StudyGroup> listGroup = [];
  List<SimpleTask> listSimpleTask = [];
  List<TimedTask> listTimedTask = [];
  List<ListTask> listAllTasks = [];
  List<GroupAndSTask> listGroupAndTask = [];
  List<GroupAndTTask> listGroupAndTTask = [];
  GroupsService groupsService = new GroupsService();
  String formatter = '';

  void getCurrentDate() async {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  void getTasks() async {
    await groupsService.getAllTasksByCourseId(widget.courseId, widget.token);
    setState(() {
      listGroup = groupsService.studyGroupList;
      listSimpleTask = groupsService.simpleTaskList;
      listTimedTask = groupsService.timedTaskList;
      listAllTasks = groupsService.listAllTasks;
      listGroupAndTask = groupsService.listGroupSTasks;
      listGroupAndTTask = groupsService.listGroupTTasks;
    });
    // for (int i = 0; i < listGroupAndTTask.length; i++) {
    //   print(listGroupAndTTask.length);
    //   print("${listGroupAndTTask[i].id}, ${listGroupAndTTask[i].taskId}");
    // }
  }

  Future<void> updateSimpleTaskData(id, token, index) async {
    var grupo = 0;
    for (int i = 0; i < listGroupAndTask.length; i++) {
      if (id == listGroupAndTask[i].taskId) {
        grupo = listGroupAndTask[i].id;
      }
    }
    print("Id del grupo $grupo");
    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$grupo/simpleTasks/$id/');

      http.Response response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token
          },
          body: jsonEncode(<String, String>{
            'finished': listSimpleTask[index].finished.toString(),
            'deadline': listSimpleTask[index].deadline,
            'title': listSimpleTask[index].title,
            'description': listSimpleTask[index].description
          }));
      print('PUT simple Task response: ${response.body}');
    } catch (e) {
      print('Caught error: $e');
    }
  }

  Future<void> updateTimedTaskData(id, token, index) async {
    var grupo = 0;
    for (int i = 0; i < listGroupAndTTask.length; i++) {
      if (id == listGroupAndTTask[i].taskId) {
        grupo = listGroupAndTTask[i].id;
      }
    }
    print("Id del grupo $grupo");
    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$grupo/timedTasks/$id/');

      http.Response response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token
          },
          body: jsonEncode(<String, String>{
            'finished': listTimedTask[index].finished.toString(),
            'startTime': listTimedTask[index].startTime,
            'finishTime': listTimedTask[index].finishTime,
            'title': listTimedTask[index].title,
            'description': listTimedTask[index].description
          }));
      print('PUT timed Task response: ${response.body}');
    } catch (e) {
      print('Caught error: $e');
    }
  }

  void initState() {
    super.initState();
    getCurrentDate();
    //getCurrentDate();

    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarSpeedplanner(context, '${widget.username}'),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(color: Color(0xffE9EBF8)),
          child: widget.conditional == 0
              ? notTasks()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Color(0xffE9EBF8)),
                      child: listAllTasks.length == 0
                          ? Container(
                              decoration: BoxDecoration(color: backgroundColor),
                              // height: size.height,
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
                                      'Cargando listado de las tareas',
                                      style: TextStyle(color: purpleColor),
                                    ),
                                  )
                                ],
                              ))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  color: widget.courseColor,
                                  child: Container(
                                    width: double.infinity,
                                    margin:
                                        EdgeInsets.only(left: 35, right: 35),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  '${widget.courseName}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Tareas Simples",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                Container(
                                    height: listSimpleTask.length * 50.0,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(right: 10, top: 10),
                                    child: listSimpleTask.length == 0
                                        ? Center(
                                            child: Text(
                                                "No hay tareas en este curso"),
                                          )
                                        : ListView.builder(
                                            itemCount: listSimpleTask.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Wrap(
                                                      direction:
                                                          Axis.horizontal,
                                                      spacing: 5.0,
                                                      children: [
                                                        Container(
                                                          height: 25,
                                                          width: 25,
                                                          child: IconButton(
                                                            padding:
                                                                new EdgeInsets
                                                                    .all(0.0),
                                                            icon: Icon(listSimpleTask[
                                                                        index]
                                                                    .finished
                                                                ? Icons
                                                                    .check_box
                                                                : Icons
                                                                    .check_box_outline_blank),
                                                            //.check_box_outline_blank,
                                                            //Icons.check_box,
                                                            onPressed: () {
                                                              setState(
                                                                () {
                                                                  listSimpleTask[
                                                                          index]
                                                                      .finished = !listSimpleTask[
                                                                          index]
                                                                      .finished;
                                                                },
                                                              );
                                                              updateSimpleTaskData(
                                                                  listSimpleTask[
                                                                          index]
                                                                      .id,
                                                                  widget.token,
                                                                  index);
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Text(
                                                            "${listSimpleTask[index].title} ",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 50,
                                                        right: 20,
                                                      ),
                                                      child: Text(
                                                        "${listSimpleTask[index].description}",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Tareas Cronometradas",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                Container(
                                    height: listTimedTask.length * 50.0,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(right: 10, top: 10),
                                    child: listTimedTask.length == 0
                                        ? Center(
                                            child: Text(
                                                "No hay tareas en este curso"),
                                          )
                                        : ListView.builder(
                                            itemCount: listTimedTask.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Wrap(
                                                      direction:
                                                          Axis.horizontal,
                                                      spacing: 5.0,
                                                      children: [
                                                        Container(
                                                          height: 25,
                                                          width: 25,
                                                          child: IconButton(
                                                            padding:
                                                                new EdgeInsets
                                                                    .all(0.0),
                                                            icon: Icon(listTimedTask[
                                                                        index]
                                                                    .finished
                                                                ? Icons
                                                                    .check_box
                                                                : Icons
                                                                    .check_box_outline_blank),
                                                            //.check_box_outline_blank,
                                                            //Icons.check_box,
                                                            onPressed: () {
                                                              setState(() {
                                                                listTimedTask[
                                                                            index]
                                                                        .finished =
                                                                    !listTimedTask[
                                                                            index]
                                                                        .finished;
                                                              });
                                                              updateTimedTaskData(
                                                                  listTimedTask[
                                                                          index]
                                                                      .id,
                                                                  widget.token,
                                                                  index);
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Text(
                                                            "${listTimedTask[index].title} ",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 50,
                                                        right: 20,
                                                      ),
                                                      child: Text(
                                                        "${listTimedTask[index].description}",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })),
                              ],
                            ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 275),
                        child: Container(
                            color: dateBG,
                            width: double.infinity,
                            child: Container(
                              // margin:
                              //     EdgeInsets.only(left: 35, right: 35, top: 5),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(top: 2, bottom: 2),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Color(0xffD7DAEB)),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Text(
                                        'Date: ' + formatter,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xff8377D1),
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            )))
                  ],
                ),
        ));
  }
}

Widget notTasks() {
  return Container(
    decoration: BoxDecoration(color: Color(0xffE9EBF8)),
    child: Center(
      child: Text(
        'No hay Tareas en este Curso',
        style: TextStyle(
            color: Color(0xff9C9DA6),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
    ),
  );
}
