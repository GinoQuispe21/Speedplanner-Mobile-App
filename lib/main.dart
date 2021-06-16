import 'package:flutter/material.dart';
import 'package:speedplanner/pages/addCourse.dart';
import 'package:speedplanner/pages/firstScreen.dart';
import 'package:speedplanner/pages/home.dart';
import 'package:speedplanner/pages/signIn.dart';
import 'package:speedplanner/pages/signUp.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Poppins'),
    initialRoute: '/firstScreen',
    routes: {
      '/': (context) => Home(),
      '/firstScreen': (context) => FirstScreen(),
      '/signin': (context) => SignIn(),
      '/signup': (context) => SignUp(),
      '/addCourse': (context) => AddCourse(),
    },
    //home: Home(),
  ));
}
