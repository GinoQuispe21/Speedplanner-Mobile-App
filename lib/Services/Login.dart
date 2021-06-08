import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:speedplanner/models/TokenUserData.dart';

var urlLogin = Uri.parse('https://speedplanner-mobile.herokuapp.com/login');

class LoginService {
  Future<TokenUserData> login(username, password) async {
    final tokenUserData = TokenUserData();
    // * Validation login
    http.Response token = await http.post(
      urlLogin,
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (token.statusCode == 200) {
      Map<String, String> headers = token.headers;
      tokenUserData.token = headers['authorization'].toString();
      print('el token es: ${tokenUserData.token}');
      // * Get user data by username using token authentication
      http.Response userResponse = await http.get(
          Uri.parse(
              'https://speedplanner-mobile.herokuapp.com/api/usersUsername/$username'),
          headers: {HttpHeaders.authorizationHeader: tokenUserData.token});
      Map userdata = jsonDecode(userResponse.body);
      tokenUserData.id = userdata['id'];
      tokenUserData.username = userdata['username'];
      tokenUserData.email = userdata['email'];
      tokenUserData.password = userdata['password'];
      tokenUserData.role = userdata['role'];
    }
    return tokenUserData;
  }
}
