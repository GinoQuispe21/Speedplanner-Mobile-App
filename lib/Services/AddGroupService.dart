import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speedplanner/models/Group.dart';

class AddGroupService {
  String groupName = '';
  String groupDescription = '';
  String courseName = '';

  Future<void> createGroup(token, courseId, members) async {
    //TODO:quitar id
    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/courses/$courseId/studyGroups');

      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token
          },
          body: jsonEncode(<String, String>{
            'name': groupName,
            'description': groupDescription
          }));
      Map groupResponse = jsonDecode(utf8.decode(response.bodyBytes));
      String groupId = groupResponse['id'].toString();
      print("groupId: " + groupId);
      print("Create group status code: ${response.statusCode}");
      print("Created group ${response.body}");

      var url2 = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/studyGroups/$groupId/members/');

      for (int i = 0; i < members.length; i++) {
        http.Response memberResponse = await http.post(url2,
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': token
            },
            body: jsonEncode(<String, String>{
              'fullName': members[i].name,
              'description': members[i].description
            }));
        print(
            'POST member response ${memberResponse.statusCode} + ${memberResponse.body} ');
      }
    } catch (e) {
      print('Caught error: $e');
    }
  }
}
