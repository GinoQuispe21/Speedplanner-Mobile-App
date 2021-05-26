import 'package:flutter/material.dart';
import 'package:speedplanner/pages/home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SafeArea(
          child: Column(
        children: <Widget>[
          Text('Sign In Screen'),
          FlatButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => Home()),
                  (route) => false,
                );
              },
              icon: Icon(
                Icons.arrow_forward_rounded,
              ),
              label: Text('Iniciar Sesion'))
        ],
      )),
    ));
  }
}
