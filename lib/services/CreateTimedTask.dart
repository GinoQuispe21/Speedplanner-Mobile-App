import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:speedplanner/models/TimedTask.dart';

class CreateTimedTaskService {
  Future<TestTimedTask> createTimedTask(groupId, token, titleTask,
      descriptionTask, startTime, finishTime, finished) async {
    final testTimedTask = new TestTimedTask();
    try {
      Response responseTimedTask = await post(
        Uri.parse(
            'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$groupId/timedTasks'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(<String, String>{
          'finished': finished.toString(),
          'startTime': startTime,
          'finishTime': finishTime,
          'title': titleTask,
          'description': descriptionTask
        }),
      );
      if (responseTimedTask.statusCode == 200) {
        Map dataSimpleTask =
            jsonDecode(utf8.decode(responseTimedTask.bodyBytes));
        testTimedTask.id = dataSimpleTask['id'];
        testTimedTask.finished = dataSimpleTask['finished'];
        testTimedTask.startTime = dataSimpleTask['startTime'];
        testTimedTask.finishTime = dataSimpleTask['finishTime'];
        testTimedTask.title = dataSimpleTask['title'];
        testTimedTask.description = dataSimpleTask['description'];
        print(
            '${testTimedTask.id} - ${testTimedTask.finished} - ${testTimedTask.startTime} - ${testTimedTask.finishTime} - ${testTimedTask.title} -${testTimedTask.description}');
      }
      return testTimedTask;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
