import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:speedplanner/models/SimpleTask.dart';

class CreateSimpleTaskService {
  //!Corregir y revisar porque no funciona
  Future<SimpleTask> createSimpleTask(
      groupId, token, titleTask, descriptionTask, deadline, finished) async {
    final simpleTask = new SimpleTask(0, false, '', '', '');
    try {
      Response responseSimpleTask = await post(
        Uri.parse(
            'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$groupId/simpleTasks'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(<String, String>{
          'finished': finished.toString(),
          'deadline': deadline,
          'title': titleTask,
          'description': descriptionTask
        }),
      );
      if (responseSimpleTask.statusCode == 200) {
        Map dataSimpleTask =
            jsonDecode(utf8.decode(responseSimpleTask.bodyBytes));
        simpleTask.id = dataSimpleTask['id'];
        simpleTask.finished = dataSimpleTask['finished'];
        simpleTask.deadline = dataSimpleTask['deadline'];
        simpleTask.title = dataSimpleTask['title'];
        simpleTask.description = dataSimpleTask['description'];
        print(
            '${simpleTask.id} - ${simpleTask.finished} - ${simpleTask.deadline} - ${simpleTask.title} -${simpleTask.description}');
      } else {
        print("aaaaaaaaa");
        print("${finished.toString()}");
        print(deadline);
        print(titleTask);
        print(descriptionTask);
      }
      return simpleTask;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
