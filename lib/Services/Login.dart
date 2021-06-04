import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var urlLogin = Uri.parse('https://speedplanner-mobile.herokuapp.com/login');

class Token {
  String token;
  Token({this.token});
}

class LoginService {
  Future<Token> login(username, password) async {
    final userToken = Token();
    http.Response token = await http.post(
      urlLogin,
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (token.statusCode == 200) {
      Map<String, String> headers = token.headers;
      userToken.token = headers['authorization'];
    }
    return userToken;
  }
}