import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:speedplanner/Services/GetAllCourses.dart';
import 'package:speedplanner/models/Group.dart';
import 'package:speedplanner/models/Member.dart';

class GroupService {
  List<Group> groups = [];
  List<Member> members = [];
  List<String> courseNames = [];
  String courseName = '';

  /* Future<void> getGroup(groupId, token, courseId, courseName) async {
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
      groups.add(new Group(
          groupData['id'], groupData['description'], courseName, members));
      print('added group:\n');
      print(groups[0].id);
      print(groups[0].description);
      print(groups[0].courseName);
    } catch (e) {
      print('caught error $e');
    }
  } */

  Future<void> getAllGroups(id, token, courseId) async {
    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/courses/$courseId/studyGroups');

      http.Response response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      });
      Map groupsResponse = jsonDecode(utf8.decode(response.bodyBytes));
      for (int i = 0; i < groupsResponse['content'].length; i++) {
        groups.add(new Group(
            groupsResponse['content'][i]['id'],
            groupsResponse['content'][i]['name'],
            groupsResponse['content'][i]['description'],
            " "));
        print(groups[i].id);
        print(groups[i].description);
      }
    } catch (e) {
      print('Caught error: $e');
    }
  }
}
