import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:speedplanner/Services/GetAllCourses.dart';
import 'package:speedplanner/models/Group.dart';
import 'package:speedplanner/models/Member.dart';

class GroupService {
  List<Group> groups = [];
  List<Member> members = [];
  String courseName = '';
  GetAllCoursesByUserIdService coursesService =
      new GetAllCoursesByUserIdService();

  Future<void> getAllGroups(id, token, courseId) async {
    await coursesService.getAllCoursesByUserId(id, token);

    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/courses/$courseId/studyGroups');

      http.Response response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        Map groupsResponse = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < groupsResponse['content'].length; i++) {
          String groupId = groupsResponse['content'][i]['id'].toString();
          print("groupId: " + groupId);

          var url2 = Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$groupId/members');
          http.Response mResponse = await http.get(url2,
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': token
              });
          print("Status code member request: ${mResponse.statusCode}");
          Map membersResponse = jsonDecode(utf8.decode(mResponse.bodyBytes));

          for (int j = 0; j < membersResponse['totalElements']; j++) {
            print("entró a for");
            print("valor: " + membersResponse['content'][j]['id'].toString());
            members.add(new Member(
                membersResponse['content'][j]['id'],
                membersResponse['content'][j]['fullName'],
                membersResponse['content'][j]['description']));
            print("Miembro agregado: " +
                members[j].id.toString() +
                " " +
                members[j].name +
                " " +
                members[j].description +
                " \n");
          }

          for (int k = 0; k < coursesService.courses.length; k++) {
            if (coursesService.courses[k].id == courseId) {
              courseName = coursesService.courses[k].name;
            }
          }

          groups.add(new Group(
              groupsResponse['content'][i]['id'],
              groupsResponse['content'][i]['name'],
              groupsResponse['content'][i]['description'],
              courseName,
              members));
          members = [];
          print("Grupo agregado con Id" + groups[i].id.toString());
          print("Grupo agregado con descripción " + groups[i].description);
          print("Grupo agregado con curso: " + courseName);
        }
      }
    } catch (e) {
      print('Caught error: $e');
    }
  }

  /* Future<void> getAllMembersFromGroup(id, token, groupId) async {
    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$groupId/members');
      http.Response response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      });
      Map membersResponse = jsonDecode(utf8.decode(response.bodyBytes));
      for (int i = 0; i < membersResponse['content'].length; i++) {
        members.add(new Member(
            membersResponse['content'][i]['id'],
            membersResponse['content'][i]['name'],
            membersResponse['content'][i]['description']));
        print("Miembro agregado: " +
            members[i].id.toString() +
            " " +
            members[i].name +
            " " +
            members[i].description +
            " \n");
      }
    } catch (e) {
      print('Caught error: $e');
    }
  } */
}
