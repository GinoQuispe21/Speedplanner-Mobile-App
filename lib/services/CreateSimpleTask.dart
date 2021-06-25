import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:speedplanner/models/SimpleTask.dart';

class CreateSimpleTaskService {
  Future<TestSimpleTask> createSimpleTask(
      groupId, token, titleTask, descriptionTask, deadline, finished) async {
    final testSimpleTask = new TestSimpleTask();
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
        testSimpleTask.id = dataSimpleTask['id'];
        testSimpleTask.finished = dataSimpleTask['finished'];
        testSimpleTask.deadline = dataSimpleTask['deadline'];
        testSimpleTask.title = dataSimpleTask['title'];
        testSimpleTask.description = dataSimpleTask['description'];
        print(
            '${testSimpleTask.id} - ${testSimpleTask.finished} - ${testSimpleTask.deadline} - ${testSimpleTask.title} -${testSimpleTask.description}');
      } else {
        print("aaaaaaaaa");
        print("${finished.toString()}");
        print(deadline);
        print(titleTask);
        print(descriptionTask);
      }
      return testSimpleTask;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
