import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:speedplanner/models/TokenUserData.dart';

var urlRegister =
    Uri.parse('https://speedplanner-mobile.herokuapp.com/api/users');
var urlLogin = Uri.parse('https://speedplanner-mobile.herokuapp.com/login');
var tokenRegister =
    'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJnaW5vIn0.bCcj99sO-yCeKqTfxBEUMinv8ei5EEsSDZy-mG1tjHaE6Z4Pn9YB7bJCrUOaqp-1pV1vXIBiPcNTY7KFWh12Zw';

class RegisterService {
  Future<TokenUserData> register(fullname, username, email, password) async {
    final tokenUserData = TokenUserData();
    try {
      http.Response responseUser = await http.post(urlRegister,
          headers: <String, String>{
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: tokenRegister
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
            'email': email
          }));
      if (responseUser.statusCode == 200) {
        print("Usuario registrado: $username");
        Map dataUser = jsonDecode(utf8.decode(responseUser.bodyBytes));
        int idUser = dataUser['id'];
        http.Response responseProfile = await http.post(
            Uri.parse(
                'https://speedplanner-mobile.herokuapp.com/api/users/$idUser/profile'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader: tokenRegister
            },
            body: jsonEncode(<String, String>{
              'fullName': fullname,
              'age': null,
              'gender': '',
            }));
        Map dataProfile = jsonDecode(utf8.decode(responseProfile.bodyBytes));
        if (responseProfile.statusCode == 200) {
          http.Response tokenLogin = await http.post(
            urlLogin,
            body: jsonEncode(<String, String>{
              'username': username,
              'password': password,
            }),
          );
          if (tokenLogin.statusCode == 200) {
            Map<String, String> headers = tokenLogin.headers;
            tokenUserData.id = dataUser['id'];
            tokenUserData.username = dataUser['username'];
            tokenUserData.password = dataUser['password'];
            tokenUserData.email = dataUser['email'];
            tokenUserData.token = headers['authorization'].toString();
          }
        }
      }
      return tokenUserData;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
