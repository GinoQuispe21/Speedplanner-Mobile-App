import 'package:flutter/material.dart';
import 'package:speedplanner/pages/addCourse.dart';
import 'package:speedplanner/pages/firstScreen.dart';
import 'package:speedplanner/pages/home.dart';
import 'package:speedplanner/pages/signIn.dart';
import 'package:speedplanner/pages/signUp.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins'),
    initialRoute: '/',
    routes: {
      '/home': (context) => Home(),
      '/': (context) => FirstScreen(),
      '/signin': (context) => SignIn(),
      '/signup': (context) => SignUp(),
      '/addCourse': (context) => AddCourse(),
    },
    //home: Home(),
  ));
}
