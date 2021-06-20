import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:speedplanner/models/CourseGroup.dart';
import 'package:speedplanner/models/GroupList.dart';

class GetAllCoursesAndGroupsByUserIdService {
  List<CourseGroup> courses = [];
  List<GroupList> groupsL = [];
  Future<void> getAllCoursesAndGroupByUserId(id, token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/users/$id/courses'),
          headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        Map coursesResponse = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < coursesResponse['content'].length; i++) {
          String controlId = coursesResponse['content'][i]['id'].toString();
          http.Response responseGroups = await http.get(
              Uri.parse(
                  'https://speedplanner-mobile.herokuapp.com/api/courses/$controlId/studyGroups'),
              headers: {HttpHeaders.authorizationHeader: token});
          Map groupsResponse =
              jsonDecode(utf8.decode(responseGroups.bodyBytes));
          for (int j = 0; j < groupsResponse['content'].length; j++) {
            groupsL.add(new GroupList(
                groupsResponse['content'][j]['id'],
                groupsResponse['content'][j]['name'],
                groupsResponse['content'][j]['description']));
          }
          courses.add(new CourseGroup(
              coursesResponse['content'][i]['id'],
              coursesResponse['content'][i]['name'],
              coursesResponse['content'][i]['description'],
              coursesResponse['content'][i]['email'],
              coursesResponse['content'][i]['color'],
              groupsL));
          groupsL = [];
        }
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
