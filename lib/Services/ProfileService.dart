import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileService {
  String name = '';
  int age = 0;
  String gender = '';

  String putName = '';
  String putAge = '';
  String putGender = '';

  Future<void> getProfileData(id, token) async {
    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/users/$id/profile/');

      http.Response response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      });
      Map profileData = jsonDecode(response.body);

      name = profileData['fullName'];
      age = profileData['age'];
      gender = profileData['gender'];

      print(age);
      print(name);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Caught error: $e');
    }
  }

  Future<void> updateProfileData(id, token) async {
    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/users/$id/profile/');

      http.Response response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token
          },
          body: jsonEncode(<String, String>{
            'fullName': putName,
            'age': putAge,
            'gender': putGender
          }));
      print('PUT name response: ${response.body}');
    } catch (e) {
      print('Caught error: $e');
    }
  }
}
