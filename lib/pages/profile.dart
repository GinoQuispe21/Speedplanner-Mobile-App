import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Perfil',
                  style: TextStyle(
                      color: purpleColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: purpleColor,
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    labelText: 'User',
                    filled: true,
                    contentPadding: EdgeInsets.all(16.0),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide:
                            BorderSide(style: BorderStyle.none, width: 0)),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: purpleColor,
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    labelText: 'Email',
                    filled: true,
                    contentPadding: EdgeInsets.all(16.0),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide:
                        BorderSide(style: BorderStyle.none, width: 0)),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: purpleColor,
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                    labelText: 'Name',
                    filled: true,
                    contentPadding: EdgeInsets.all(16.0),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide:
                        BorderSide(style: BorderStyle.none, width: 0)),
                  ),
                )
              ],
            ),
          ]),
    ));
  }
}
