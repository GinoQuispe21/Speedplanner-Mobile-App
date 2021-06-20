import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:speedplanner/models/SimpleTask.dart';

class SimpleTaskService {
  List<SimpleTask> simpleTaskList = [];
  Future<void> getAllGroupsByCourseId(id, token) async {
    try {
      Response response = await get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$id/simpleTasks'),
          headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        Map dataSimpleTask = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < dataSimpleTask['content'].length; i++) {
          simpleTaskList.add(new SimpleTask(
            dataSimpleTask['content'][i]['id'],
            dataSimpleTask['content'][i]['finished'],
            dataSimpleTask['content'][i]['deadline'],
            dataSimpleTask['content'][i]['title'],
            dataSimpleTask['content'][i]['description'],
          ));
        }
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
