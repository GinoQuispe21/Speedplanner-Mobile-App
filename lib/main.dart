import 'package:flutter/material.dart';
import 'package:speedplanner/pages/home.dart';
import 'package:speedplanner/pages/sign-in.dart';

void main() {
  runApp(MaterialApp(
    routes: {'/': (context) => Home(), '/signin': (context) => signIn()},
  ));
}
