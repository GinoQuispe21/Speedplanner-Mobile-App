import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speedplanner/models/User.dart';
import 'package:speedplanner/pages/ChangePassword.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/footer.dart';
import 'package:speedplanner/utils/textInput.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController email = TextEditingController();
  List<User> users = [];
  var newId;
  var newUsername;
  var newEmail;
  bool isReady = false;

  var tokenRegister =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJnaW5vIn0.bCcj99sO-yCeKqTfxBEUMinv8ei5EEsSDZy-mG1tjHaE6Z4Pn9YB7bJCrUOaqp-1pV1vXIBiPcNTY7KFWh12Zw';

  Future<void> getAllUsers() async {
    users = [];
    try {
      http.Response response = await http.get(
          Uri.parse('https://speedplanner-mobile.herokuapp.com/api/users/'),
          headers: {HttpHeaders.authorizationHeader: tokenRegister});
      if (response.statusCode == 200) {
        Map usersResponse = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < usersResponse['content'].length; i++) {
          users.add(new User(
            usersResponse['content'][i]['id'],
            usersResponse['content'][i]['username'],
            usersResponse['content'][i]['password'],
            usersResponse['content'][i]['email'],
            usersResponse['content'][i]['role'],
          ));
          print('User agarrado');
        }
      }
    } catch (e) {
      print('caught error $e');
      return null;
    }
    for (int i = 0; i < users.length; i++) {
      if (email.text == users[i].email) {
        newId = users[i].id;
        newUsername = users[i].username;
        newEmail = users[i].email;
        print('Id conseguido: $newUsername');
        print('Correo: ${users[i].email}');
        setState(() {
          isReady = true;
        });
      }
    }
    if (newId == 0) {
      print('no se encontró el correo ingresado');
    }
    if (isReady == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangePassword(
                  id: newId,
                  token: tokenRegister,
                  username: newUsername,
                  email: newEmail,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
                colors: <Color>[greenColor, purpleColor])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              margin: EdgeInsets.only(top: 50),
              child: Image.asset('assets/logo.png'),
            ),
            Container(
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Encuentra el usuario',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    textInput(
                        hint: "Correo del usuario",
                        icon: Icons.email,
                        controller: email,
                        top: 50.0,
                        type: TextInputType.name,
                        password: false),
                    Container(
                        margin: EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 47,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: StadiumBorder(),
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                            onPressed: () {
                              getAllUsers();
                              if (isReady == true) {}
                            },
                            child: Text(
                              'Encontrar usuario',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic),
                            )))
                  ],
                ),
              ),
            ),
            footer(context: context)
          ],
        ),
      ),
    );
  }
}
