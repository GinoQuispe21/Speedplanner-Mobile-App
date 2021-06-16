import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 6000), () {
      Navigator.pushNamed(context, '/signin');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.topLeft,
                      begin: Alignment.bottomRight,
                      colors: <Color>[greenColor, purpleColor])),
              child: Container(
                height: size.height,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                    Positioned(
                      top: (size.height / 2) + 25,
                      child: RichText(
                          text: TextSpan(
                        text: 'No sólo organices tu rutina. ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Poppins'),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Optimízala',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins'))
                        ],
                      )),
                    ),
                    Positioned(
                        bottom: 10,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Un producto hecho por',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              Image(
                                  image: AssetImage(
                                      'assets/fasttech_logo_dark.png'),
                                  width: 150,
                                  height: 40),
                              Text(
                                '©2021',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ))),
    );
  }
}
