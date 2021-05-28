import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speedplanner/pages/signIn.dart';
import 'package:speedplanner/utils/colors.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 5000), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => SignIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.topLeft,
              begin: Alignment.bottomRight,
              colors: <Color>[greenColor, purpleColor])),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            SizedBox(height: 10.0),
            Text('No solo organices tu rutina. Optimizala',
                style: TextStyle(color: Colors.white, fontSize: 17)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Un producto hecho por',
                    style: TextStyle(color: Colors.white, fontSize: 17))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
