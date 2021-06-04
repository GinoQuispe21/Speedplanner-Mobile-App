import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var url = Uri.parse('https://speedplanner-mobile.herokuapp.com/api/users');

class RegisterService {
  Future<http.Response> register(username, email, password) async {
    http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader:
              'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJnaW5vIn0.bCcj99sO-yCeKqTfxBEUMinv8ei5EEsSDZy-mG1tjHaE6Z4Pn9YB7bJCrUOaqp-1pV1vXIBiPcNTY7KFWh12Zw'
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'email': email
        }));
    if (response.statusCode == 200) {
      print("Usuario registrado: $username");
    }
    return response;
  }
}
