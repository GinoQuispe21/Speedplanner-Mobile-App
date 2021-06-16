import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  String user = '';
  String email = '';

  String putUser = '';
  String putEmail = '';

  Future<void> getUserData(id, token) async {
    try {
      var url =
          Uri.parse('https://speedplanner-mobile.herokuapp.com/api/users/$id');

      http.Response response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token
      });
      Map userData = jsonDecode(response.body);
      print(userData);
      user = userData['username'];
      email = userData['email'];

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Caught error: $e');
    }
  }

  Future<void> updateUserData(id, token) async {
    try {
      var url = Uri.parse(
          'https://speedplanner-mobile.herokuapp.com/api/users/$id/fields');

      http.Response response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token
          },
          body: jsonEncode(
              <String, String>{'username': putUser, 'email': putEmail}));
      print('PUT user Response status: ${response.statusCode}');
      print('PUT user Response: ${response.body}');
      print('updated data');
    } catch (e) {
      print('Caught error: $e');
    }
  }
}
