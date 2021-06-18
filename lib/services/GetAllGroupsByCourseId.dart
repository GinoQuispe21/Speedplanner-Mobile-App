import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:speedplanner/models/StudyGroup.dart';

class GroupsService {
  List<StudyGroup> studyGroupList = [];
  Future<void> getAllGroupsByCourseId(id, token) async {
    try {
      Response response = await get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/courses/$id/studyGroups'),
          headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        Map dataGroups = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < dataGroups['content'].length; i++) {
          studyGroupList.add(new StudyGroup(
            dataGroups['content'][i]['id'],
            dataGroups['content'][i]['name'],
            dataGroups['content'][i]['description'],
          ));
        }
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
