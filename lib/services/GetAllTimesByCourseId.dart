/*import 'dart:convert';
import 'dart:io';

import 'package:speedplanner/models/Time.dart';
import 'package:http/http.dart' as http;

class GetAllTimesByUserIdService {
  List<Time> listTime;
  Future<void> getAllTimesByUserId(courseId, token) async {
    try {
      http.Response responseTimes = await http.get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/courses/$courseId/times'),
          headers: {HttpHeaders.authorizationHeader: token});
      if (responseTimes.statusCode == 200) {
        Map responseTimesList =
            jsonDecode(utf8.decode(responseTimes.bodyBytes));
        for (int i = 0; i < responseTimesList['content'].length; i++) {
          listTime.add(new Time(
              responseTimesList['content'][i]['id'],
              responseTimesList['content'][i]['day'],
              responseTimesList['content'][i]['startTime'],
              responseTimesList['content'][i]['finishTime']));
        }
        print(
            'Tamaño del arreglo de tiempos del curso es: ${responseTimesList['content'].length}');
        for (int i = 0; i < responseTimesList['content'].length; i++) {
          print(
              '${listTime[i].id} ${listTime[i].day}  ${listTime[i].startTime} ${listTime[i].finishTime}');
        }
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
  }
}
*/