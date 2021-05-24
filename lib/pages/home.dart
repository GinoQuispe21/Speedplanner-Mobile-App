import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    return Scaffold(
        appBar: AppBar(
          title: Text('Speedplanner'),
          backgroundColor: Colors.purple[800],
        ),
        body: Container(
            child: Center(
          child: Text('Home Screen'),
        )));
  }
}
