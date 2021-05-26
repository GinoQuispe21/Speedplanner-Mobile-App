import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color(0xffE9EBF8)),
        child: Center(
          child: Text('Todavia no hay grupos'),
        ));
  }
}
