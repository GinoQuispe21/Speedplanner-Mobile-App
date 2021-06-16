import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  String user = '';
  String email = '';
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
}
