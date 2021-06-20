import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:speedplanner/Services/GetAllCourses.dart';
import 'package:speedplanner/models/Group.dart';

class GroupService {
  List<Group> groups = [];
  String courseName = '';

  Future<void> getGroup(groupId, token, courseId, courseName) async {
    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/courses/$courseId/studyGroups/$groupId');

      http.Response response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      });

      print('Get group status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map groupData = jsonDecode(response.body);
      groups.add(
          new Group(groupData['id'], groupData['description'], courseName));
      print('added group:\n');
      print(groups[0].id);
      print(groups[0].description);
      print(groups[0].courseName);
    } catch (e) {
      print('caught error $e');
    }
  }

  Future<void> getCourseName(id, token, courseId) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/users/$id/courses'),
          headers: {HttpHeaders.authorizationHeader: token});
      Map course = jsonDecode(utf8.decode(response.bodyBytes));
      courseName = course['name'];
    } catch (e) {
      print('caught error $e');
    }
  }
}
