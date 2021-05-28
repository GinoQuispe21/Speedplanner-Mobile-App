import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

import 'package:speedplanner/pages/home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
                colors: <Color>[purpleColor, greenColor])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              margin: EdgeInsets.only(top: 50),
              child: Image.asset('assets/logo.png'),
            ),
            Container(
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    _textInput(hint: "Usuario", icon: Icons.person),
                    _textInput(hint: "Contraseña", icon: Icons.lock),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Se me olvido mi contraseña',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic),
                            ))),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: TextButton(
                        onPressed: () {},
                        child: Text('¿No posee cuenta?, registrarse',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 47,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: StadiumBorder(),
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Home()),
                                (route) => false,
                              );
                            },
                            child: Text(
                              'Iniciar Sesión',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )))
                  ],
                ),
              ),
            ),
            Container(
              color: backgroundColor,
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Un producto echo por'),
                    Image(
                        image: AssetImage('assets/fasttech_logo.png'),
                        width: 150,
                        height: 40),
                    Text('©2021')
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _textInput({controller, hint, icon}) {
  return Container(
    margin: EdgeInsets.only(top: 50),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(40)),
      color: backgroundColor,
    ),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(
            icon,
          )),
    ),
  );
}