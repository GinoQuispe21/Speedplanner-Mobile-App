import 'package:flutter/material.dart';
import 'package:speedplanner/pages/home.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/textInput.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[greenColor, purpleColor, greenColor])),
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
                      'Registrar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    textInput(hint: "Nombre", icon: Icons.person, top: 20.0),
                    textInput(hint: "Usuario", icon: Icons.account_circle, top: 20.0),
                    textInput(hint: "Correo electrónico", icon: Icons.email, top: 20.0),
                    textInput(hint: "Contraseña", icon: Icons.lock, top: 20.0),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signin');
                        },
                        child: Text('¿Posee una cuenta? Iniciar sesión',
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
                              'Registrarse',
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
