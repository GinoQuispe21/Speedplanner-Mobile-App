import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:speedplanner/models/Group.dart';
import 'package:speedplanner/models/STask.dart';

class GetAllTasksByGroupIdService {
  List<Group> groups = [];
  List<STask> sTasks = [];
  Future<void> getAllTasksByGroupId(id, token) async {
    try {
      groups = [];
      http.Response response = await http.get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/courses/$id/studyGroups'),
          headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        Map groupsResponse = jsonDecode(utf8.decode(response.bodyBytes));

        for (int i = 0; i < groupsResponse['content'].length; i++) {
          String controlId = groupsResponse['content'][i]['id'].toString();
          http.Response responseSTasks = await http.get(
              Uri.parse(
                  'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$controlId/simpleTasks'),
              headers: {HttpHeaders.authorizationHeader: token});

          Map sTaskResponse = jsonDecode(utf8.decode(responseSTasks.bodyBytes));
          for (int j = 0; j < sTaskResponse['content'].length; j++) {
            sTasks.add(new STask(
                sTaskResponse['content'][j]['id'],
                sTaskResponse['content'][j]['title'],
                sTaskResponse['content'][j]['finished'],
                sTaskResponse['content'][j]['deadline']));
          }

          groups.add(new Group(
              groupsResponse['content'][i]['id'],
              groupsResponse['content'][i]['name'],
              groupsResponse['content'][i]['description'],
              sTasks));
          sTasks = [];
        }
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
