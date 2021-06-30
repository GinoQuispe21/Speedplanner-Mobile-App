import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class DeleteCourse {
  Future<void> deleteCoursesByUserId(userId, courseId, token) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(
            'https://speedplanner-mobile.herokuapp.com/api/users/$userId/courses/$courseId'),
        headers: {HttpHeaders.authorizationHeader: token},
      );
      if (response.statusCode == 200) {
        print("aaa");
        print(response);
      }
    } catch (e) {
      print('caught error $e');
    }
  }
}

class UpdateCourse {
  Future<void> updateCourseByUserId(userId, courseId, token, nameCourse,
      descriptionCourse, emailCourse, colorCourse) async {
    try {
      http.Response response = await http.put(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/users/$userId/courses/$courseId'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token
          },
          body: jsonEncode(<String, String>{
            'name': nameCourse,
            'description': descriptionCourse,
            'email': emailCourse,
            'color': colorCourse,
          }));
      if (response.statusCode == 200) {
        print("Curso actualizado");
        print(response);
      }
    } catch (e) {}
  }
}
