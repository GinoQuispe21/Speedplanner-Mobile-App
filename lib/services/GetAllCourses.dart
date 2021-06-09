//import 'package:speedplanner/models/Course.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:speedplanner/models/Course.dart';

class GetAllCoursesByUserIdService {
  List<Course> courses = [];
  Future<void> getAllCoursesByUserId(id, token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/users/$id/courses'),
          headers: {HttpHeaders.authorizationHeader: token});
      Map coursesResponse = jsonDecode(utf8.decode(response.bodyBytes));

      for (int i = 0; i < coursesResponse['content'].length; i++) {
        courses.add(new Course(
          coursesResponse['content'][i]['id'],
          coursesResponse['content'][i]['name'],
          coursesResponse['content'][i]['description'],
          coursesResponse['content'][i]['email'],
        ));
      }
      print(coursesResponse['content'].length);
      for (int i = 0; i < coursesResponse['content'].length; i++) {
        print(
            '${courses[i].id} ${courses[i].name}  ${courses[i].email} ${courses[i].description}');
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
