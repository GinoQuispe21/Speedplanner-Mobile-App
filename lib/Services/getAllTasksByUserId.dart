import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:speedplanner/models/HardModels/Group.dart';
import 'package:speedplanner/models/HardModels/GroupAndSTask.dart';
import 'package:speedplanner/models/HardModels/GroupAndTTasks.dart';
import 'package:speedplanner/models/HardModels/LisTasks.dart';

import 'package:speedplanner/models/HardModels/STask.dart';
import 'package:speedplanner/models/HardModels/TTask.dart';

class GroupsService {
  List<StudyGroup> studyGroupList = [];
  List<SimpleTask> simpleTaskList = [];
  List<TimedTask> timedTaskList = [];
  List<ListTask> listAllTasks = [];
  List<GroupAndSTask> listGroupSTasks = [];
  List<GroupAndTTask> listGroupTTasks = [];
  Future<void> getAllTasksByCourseId(id, token) async {
    try {
      Response response = await get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/courses/$id/studyGroups'),
          headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        Map dataGroups = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < dataGroups['content'].length; i++) {
          //Add all the simple task for the course id in the simple task array
          String groupId = dataGroups['content'][i]['id'].toString();
          Response responseSimpleTask = await get(
              Uri.parse(
                  'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$groupId/simpleTasks'),
              headers: {HttpHeaders.authorizationHeader: token});
          if (responseSimpleTask.statusCode == 200) {
            Map dataSimpleTask =
                jsonDecode(utf8.decode(responseSimpleTask.bodyBytes));
            for (int j = 0; j < dataSimpleTask['content'].length; j++) {
              simpleTaskList.add(new SimpleTask(
                dataSimpleTask['content'][j]['id'],
                dataSimpleTask['content'][j]['finished'],
                dataSimpleTask['content'][j]['deadline'],
                dataSimpleTask['content'][j]['title'],
                dataSimpleTask['content'][j]['description'],
              ));
              listGroupSTasks.add(new GroupAndSTask(
                dataGroups['content'][i]['id'],
                dataSimpleTask['content'][j]['id'],
              ));
              listAllTasks.add(new ListTask(
                dataSimpleTask['content'][j]['id'],
                '(TS)',
                dataSimpleTask['content'][j]['title'],
                dataSimpleTask['content'][j]['finished'],
              ));
            }
          }

          Response responseTimedTask = await get(
              Uri.parse(
                  'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$groupId/timedTasks'),
              headers: {HttpHeaders.authorizationHeader: token});

          if (responseTimedTask.statusCode == 200) {
            Map dataTimedTask =
                jsonDecode(utf8.decode(responseTimedTask.bodyBytes));
            for (int k = 0; k < dataTimedTask['content'].length; k++) {
              timedTaskList.add(new TimedTask(
                dataTimedTask['content'][k]['id'],
                dataTimedTask['content'][k]['finished'],
                dataTimedTask['content'][k]['startTime'],
                dataTimedTask['content'][k]['finishTime'],
                dataTimedTask['content'][k]['title'],
                dataTimedTask['content'][k]['description'],
              ));
              listGroupTTasks.add(new GroupAndTTask(
                dataGroups['content'][i]['id'],
                dataTimedTask['content'][k]['id'],
              ));
              listAllTasks.add(new ListTask(
                dataTimedTask['content'][k]['id'],
                '(TC)',
                dataTimedTask['content'][k]['title'],
                dataTimedTask['content'][k]['finished'],
              ));
            }
          }

          studyGroupList.add(new StudyGroup(
            dataGroups['content'][i]['id'],
            dataGroups['content'][i]['name'],
            dataGroups['content'][i]['description'],
          ));
        }
        // print("Lista de Tareas Simple:");
        // for (int i = 0; i < simpleTaskList.length; i++) {
        //   print('${simpleTaskList[i].id} - ${simpleTaskList[i].title}');
        // }
        // print("Lista de Tareas Cronometradas:");
        // for (int i = 0; i < timedTaskList.length; i++) {
        //   print('${timedTaskList[i].id} - ${timedTaskList[i].title}');
        // }
        // int sizeListTasks = simpleTaskList.length + timedTaskList.length;
        // print("--------------------------------");
        // print("El arreglo del total de tareas: ");
        // print('Tamaño del arreglo: $sizeListTasks');
        // for (int i = 0; i < sizeListTasks; i++) {
        //   print(
        //       ' - ${listAllTasks[i].type} - ${listAllTasks[i].id} - ${listAllTasks[i].title}');
        // }
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
