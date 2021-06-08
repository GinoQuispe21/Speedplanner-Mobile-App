import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBarSpeedplanner({name}) {
  return AppBar(
    title: Text('Speedplanner'),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xff30B18B), Color(0xff8377d1)],
      )),
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20, 10.0, 0),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              print("Nueva notificacion");
            },
            child: Icon(
              Icons.notifications,
              size: 26.0,
              color: Colors.white,
            ),
          )),
      Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: GestureDetector(
          onTap: () {
            print("settings");
          },
          child: Icon(
            Icons.more_vert,
            size: 26.0,
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}
