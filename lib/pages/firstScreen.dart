import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Center(
            child: Text('First Screen'),
          ),
          FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              icon: Icon(
                Icons.arrow_forward_rounded,
              ),
              label: Text('sign-in')),
          FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              icon: Icon(
                Icons.arrow_forward_rounded,
              ),
              label: Text('sign-up'))
        ],
      ),
    ));
  }
}
