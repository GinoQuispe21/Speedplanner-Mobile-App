import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:speedplanner/models/SimpleTaskUpdateModel.dart';
import 'package:speedplanner/models/TimedTaskUpdateModel.dart';

class DeleteTaskService {
  Future<void> deleteTaskByStudyGroupId(
      studyGroupId, typeTask, taskId, token) async {
    try {
      if (typeTask == "(TS)") {
        print("SE VA ELIMINAR UNA TAREA SIMPLE");
        Response responseST = await delete(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$studyGroupId/simpleTasks/$taskId'),
          headers: {HttpHeaders.authorizationHeader: token},
        );
        if (responseST.statusCode == 200) {
          print("TAREEEEEEEEEEEAAAAAAAAAAAAAA ELIMINADAAAAAAAAAAAAAAAA");
          print(responseST);
        }
      } else {
        if (typeTask == "(TC)") {
          print("SE VA ELIMINAR UNA TAREA CRONOMETRADA");
          Response responseTC = await delete(
            Uri.parse(
                'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$studyGroupId/timedTasks/$taskId'),
            headers: {HttpHeaders.authorizationHeader: token},
          );
          if (responseTC.statusCode == 200) {
            print("TAREEEEEEEEEEEAAAAAAAAAAAAAA ELIMINADAAAAAAAAAAAAAAAA");
            print(responseTC);
          }
        }
      }
      print(studyGroupId);
      print(typeTask);
      print(taskId);
      print(token);
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}

class UpdateSimpleTaskService {
  Future<void> updateSimpleTaskByStudyGroupId(studyGroupId, taskId, token,
      finished, deadline, title, description) async {
    try {
      Response response = await put(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$studyGroupId/simpleTasks/$taskId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token
          },
          body: jsonEncode(<String, String>{
            'finished': finished,
            'deadline': deadline,
            'title': title,
            'description': description
          }));
      if (response.statusCode == 200) {
        print("Tarea actualizada");
        Map dataSimpleTask = jsonDecode(utf8.decode(response.bodyBytes));
        print('${dataSimpleTask['title']}');
        print('${dataSimpleTask['finished']}');
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}

class UpdateTimedTaskService {
  Future<void> updateTimedTaskByStudyGroupId(studyGroupId, taskId, token,
      finished, inicio, fin, title, description) async {
    try {
      Response response = await put(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$studyGroupId/timedTasks/$taskId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token
          },
          body: jsonEncode(<String, String>{
            'finished': finished,
            'startTime': inicio,
            'finishTime': fin,
            'title': title,
            'description': description
          }));
      if (response.statusCode == 200) {
        print("Tarea actualizada");
        Map dataSimpleTask = jsonDecode(utf8.decode(response.bodyBytes));
        print('${dataSimpleTask['title']}');
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}

class GetSimpleTaskService {
  SimpleTaskUpdateModel simpleTaskUpdateModel;
  Future<void> getSimpleTaskByStudyGroupId(studyGroupId, taskId, token) async {
    try {
      Response response = await get(
        Uri.parse(
            'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$studyGroupId/simpleTasks/$taskId'),
        headers: {HttpHeaders.authorizationHeader: token},
      );
      if (response.statusCode == 200) {
        Map dataSimpleTask = jsonDecode(utf8.decode(response.bodyBytes));
        simpleTaskUpdateModel = new SimpleTaskUpdateModel(
            dataSimpleTask['id'],
            dataSimpleTask['finished'],
            dataSimpleTask['deadline'],
            dataSimpleTask['title'],
            dataSimpleTask['description']);
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}

class GetTimedTaskService {
  TimedTaskUpdateModel timedTaskUpdateModel;
  Future<void> getTimedTaskByStudyGroupId(studyGroupId, taskId, token) async {
    try {
      Response response = await get(
        Uri.parse(
            'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$studyGroupId/timedTasks/$taskId'),
        headers: {HttpHeaders.authorizationHeader: token},
      );
      if (response.statusCode == 200) {
        Map dataTimedTask = jsonDecode(utf8.decode(response.bodyBytes));
        timedTaskUpdateModel = new TimedTaskUpdateModel(
            dataTimedTask['id'],
            dataTimedTask['finished'],
            dataTimedTask['startTime'],
            dataTimedTask['finishTime'],
            dataTimedTask['title'],
            dataTimedTask['description']);
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
