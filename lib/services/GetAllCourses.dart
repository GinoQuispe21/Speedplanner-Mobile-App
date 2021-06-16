//import 'package:speedplanner/models/Course.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:speedplanner/models/Course.dart';
import 'package:speedplanner/models/Time.dart';

class GetAllCoursesByUserIdService {
  List<Time> times = [];
  List<Course> courses = [];
  Future<void> getAllCoursesByUserId(id, token) async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/users/$id/courses'),
          headers: {HttpHeaders.authorizationHeader: token});
      if (response.statusCode == 200) {
        Map coursesResponse = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < coursesResponse['content'].length; i++) {
          courses.add(new Course(
            coursesResponse['content'][i]['id'],
            coursesResponse['content'][i]['name'],
            coursesResponse['content'][i]['description'],
            coursesResponse['content'][i]['email'],
            coursesResponse['content'][i]['color'],
          ));
          http.Response responseTimes = await http.get(
              Uri.parse(
                  'https://speedplanner-mobile.herokuapp.com/api/courses/${coursesResponse['content'][i]['id']}/times'),
              headers: {HttpHeaders.authorizationHeader: token});
          /*if (responseTimes.statusCode == 200) {
            Map responseTimesList =
                jsonDecode(utf8.decode(responseTimes.bodyBytes));
            for (int i = 0; i < responseTimesList['content'].length; i++) {
              times.add(new Time(
                  responseTimesList['content'][i]['id'],
                  responseTimesList['content'][i]['day'],
                  responseTimesList['content'][i]['startTime'],
                  responseTimesList['content'][i]['finishTime']));
            }
            print("-----------------");
            print(
                '${courses[i].id} ${courses[i].name}  ${courses[i].email} ${courses[i].description}');
            print(
                'Tamaño del arreglo de tiempos del curso es: ${responseTimesList['content'].length}');
            for (int i = 0; i < responseTimesList['content'].length; i++) {
              print(
                  '${times[i].id} ${times[i].day}  ${times[i].startTime} ${times[i].finishTime}');
            }
          }*/
        }
        /*print(coursesResponse['content'].length);
        for (int i = 0; i < coursesResponse['content'].length; i++) {
          print(
              '${courses[i].id} ${courses[i].name}  ${courses[i].email} ${courses[i].description}');
        }*/
        /*http.Response responseTimes = await http.get(
            Uri.parse(
                'https://speedplanner-mobile.herokuapp.com/api/courses/2/times'),
            headers: {HttpHeaders.authorizationHeader: token});
        if (responseTimes.statusCode == 200) {
          Map responseTimesList =
              jsonDecode(utf8.decode(responseTimes.bodyBytes));
          for (int i = 0; i < responseTimesList['content'].length; i++) {
            times.add(new Time(
                responseTimesList['content'][i]['id'],
                responseTimesList['content'][i]['day'],
                responseTimesList['content'][i]['startTime'],
                responseTimesList['content'][i]['finishTime']));
          }
          print(responseTimesList['content'].length);
          for (int i = 0; i < responseTimesList['content'].length; i++) {
            print(
                '${times[i].id} ${times[i].day}  ${times[i].startTime} ${times[i].finishTime}');
          }
        }*/
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
