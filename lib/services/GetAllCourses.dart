//import 'package:speedplanner/models/Course.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:speedplanner/models/Course.dart';
import 'package:speedplanner/models/Time.dart';

class GetAllCoursesByUserIdService {
  List<Course> courses = [];
  List<Time> times = [];
  Future<void> getAllCoursesByUserId(id, token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/users/$id/courses'),
          headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        Map coursesResponse = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < coursesResponse['content'].length; i++) {
          String controlId = coursesResponse['content'][i]['id'].toString();
          http.Response responseTimes = await http.get(
              Uri.parse(
                  'https://speedplanner-mobile.herokuapp.com/api/courses/$controlId/times'),
              headers: {HttpHeaders.authorizationHeader: token});
          Map timesResponse = jsonDecode(utf8.decode(responseTimes.bodyBytes));
          for (int j = 0; j < timesResponse['content'].length; j++) {
            times.add(new Time(
                timesResponse['content'][j]['id'],
                timesResponse['content'][j]['day'],
                timesResponse['content'][j]['startTime'],
                timesResponse['content'][j]['finishTime']));
          }
          courses.add(new Course(
              coursesResponse['content'][i]['id'],
              coursesResponse['content'][i]['name'],
              coursesResponse['content'][i]['description'],
              coursesResponse['content'][i]['email'],
              coursesResponse['content'][i]['color'],
              times));
          times = [];
        }
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
