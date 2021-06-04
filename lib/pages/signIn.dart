import 'package:flutter/material.dart';
import 'package:speedplanner/Services/Login.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/pages/home.dart';
import 'package:speedplanner/utils/textInput.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  LoginService loginservice = new LoginService();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String token = '';

  void _login() async {
    Token tokenResponse =
        await loginservice.login(username.text, password.text);
    setState(() {
      token = tokenResponse.token;
    });

    if (token != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Home()),
        (route) => false,
      );
      print(token);
    } else {
      print("Error al iniciar sesión");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topLeft,
                begin: Alignment.bottomRight,
                colors: <Color>[greenColor, purpleColor])),
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
                    textInput(
                        hint: "Usuario",
                        icon: Icons.person,
                        controller: username,
                        top: 50.0,
                        type: TextInputType.name,
                        password: false),
                    textInput(
                        hint: "Contraseña",
                        icon: Icons.lock,
                        controller: password,
                        top: 50.0,
                        type: TextInputType.text,
                        password: true),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Se me olvidó mi contraseña',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic),
                            ))),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text('¿No posee cuenta?, Regístrese',
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
                              _login();
                            },
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic),
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
                    Text('Un producto hecho por'),
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
