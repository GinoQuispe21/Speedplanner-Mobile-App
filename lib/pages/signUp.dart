import 'package:flutter/material.dart';
import 'package:speedplanner/Services/Register.dart';
import 'package:speedplanner/pages/home.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/textInput.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speedplanner/utils/footer.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegisterService registerService = new RegisterService();
  TextEditingController fullName = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _register() async {
    http.Response response =
        await registerService.register(user.text, email.text, password.text);
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Home()),
        (route) => false,
      );
      Fluttertoast.showToast(
          msg: "Bienvenido a SpeedPlanner",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff30B18B),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error al crear usuario",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffF87575),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

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
                    textInput(
                        hint: "Nombre",
                        icon: Icons.person,
                        top: 20.0,
                        controller: fullName,
                        type: TextInputType.name,
                        password: false),
                    textInput(
                        hint: "Usuario",
                        icon: Icons.account_circle,
                        top: 20.0,
                        controller: user,
                        type: TextInputType.text,
                        password: false),
                    textInput(
                        hint: "Correo electrónico",
                        icon: Icons.email,
                        top: 20.0,
                        controller: email,
                        type: TextInputType.emailAddress,
                        password: false),
                    textInput(
                        hint: "Contraseña",
                        icon: Icons.lock,
                        top: 20.0,
                        controller: password,
                        type: TextInputType.text,
                        password: true),
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
                              //getValues();
                              _register();
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
            footer(context: context)
          ],
        ),
      ),
    );
  }
}
