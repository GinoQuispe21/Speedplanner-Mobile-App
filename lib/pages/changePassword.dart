import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/footer.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePassword extends StatefulWidget {
  final int id;
  final String token;
  final String username;
  final String email;

  ChangePassword({this.id, this.token, this.username, this.email, Key key})
      : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController nPassword = TextEditingController();
  TextEditingController confirmNPassword = TextEditingController();
  bool _isHidden = true;

  Future<void> updatePassword(id, token, username, email, password) async {
    if (nPassword.text == '' || nPassword.text == confirmNPassword.text) {
      try {
        var url = Uri.parse(
            'https://speedplanner-mobile.herokuapp.com/api/users/$id/');

        http.Response response = await http.put(url,
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': token
            },
            body: jsonEncode(<String, String>{
              'username': username,
              'password': password,
              'email': email
            }));
        print('PUT password response: ${response.body}');
        Navigator.pushNamed(context, '/signin');
      } catch (e) {
        print('Caught error: $e');
      }
    } else {
      print('Error al cambiar contraseña');
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
                      'Usuario ${widget.username}, inegre su nueva contraseña',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 50.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: backgroundColor,
                      ),
                      padding: EdgeInsets.only(left: 2),
                      child: TextField(
                        controller: nPassword,
                        keyboardType: TextInputType.text,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nueva Contraseña",
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isHidden = !_isHidden;
                                });
                              }),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 50.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: backgroundColor,
                      ),
                      padding: EdgeInsets.only(left: 2),
                      child: TextField(
                        controller: confirmNPassword,
                        keyboardType: TextInputType.text,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Confirmar Nueva Contraseña",
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isHidden = !_isHidden;
                                });
                              }),
                        ),
                      ),
                    ),
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
                              print(
                                '${nPassword.text} - ${confirmNPassword.text}',
                              );
                              updatePassword(
                                  widget.id,
                                  widget.token,
                                  widget.username,
                                  widget.email,
                                  nPassword.text);
                            },
                            child: Text(
                              'Cambiar Contraseña',
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
