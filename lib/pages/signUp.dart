import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:speedplanner/models/TokenUserData.dart';
import 'package:speedplanner/pages/privacyPolicy.dart';
import 'package:speedplanner/pages/termsOfService.dart';
import 'package:speedplanner/services/Register.dart';
//import 'package:speedplanner/pages/home.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/textInput.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speedplanner/utils/footer.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TapGestureRecognizer _recognizerTermsOfService;
  TapGestureRecognizer _recognizerPrivacyPolicy;
  RegisterService registerService = new RegisterService();
  TextEditingController fullName = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String token = '';
  int id = 0;
  String usernameData = '';
  String emailData = '';
  String passwordData = '';
  bool _isHidden = true;
  bool aceptTOSandPP = false;

  _errorShortPassword() {
    Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: Color(0xffF87575),
          descStyle: TextStyle(color: Colors.white, fontSize: 15),
          titleStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        title: "Error",
        desc: "La contraseña es muy corta, ingrese otra por favor",
        buttons: [
          DialogButton(
              child: Text(
                "Aceptar",
                style: TextStyle(color: Color(0xffF87575), fontSize: 17),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.white),
        ]).show();
  }

  _errorIncompleteData() {
    Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: Color(0xffF87575),
          descStyle: TextStyle(color: Colors.white, fontSize: 15),
          titleStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        title: "Error",
        desc: "Ingrese todos los campos solicitados por favor.",
        buttons: [
          DialogButton(
              child: Text(
                "Aceptar",
                style: TextStyle(color: Color(0xffF87575), fontSize: 17),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.white),
        ]).show();
  }

  _errorAceptTOSandPP() {
    Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: Color(0xffF87575),
          descStyle: TextStyle(color: Colors.white, fontSize: 15),
          titleStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        title: "Error",
        desc:
            "Debe aceptar los terminos y condiciones para poder crear su cuenta en Speedplanner.",
        buttons: [
          DialogButton(
              child: Text(
                "Aceptar",
                style: TextStyle(color: Color(0xffF87575), fontSize: 17),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.white),
        ]).show();
  }

  void _validationRegister() async {
    if (fullName.text == '' ||
        fullName.text == '' ||
        email.text == '' ||
        password.text == '') {
      print("aaaaaaaaaaaaaaaaaaaa");
      _errorIncompleteData();
    } else {
      if (password.text.length < 7) {
        _errorShortPassword();
      } else {
        if (aceptTOSandPP == false) {
          print("no acepte");
          _errorAceptTOSandPP();
        } else {
          print("acepte");
          _register();
        }
      }
      //_register();
    }
  }

  void _register() async {
    TokenUserData tokenUserData = await registerService.register(
        fullName.text, user.text, email.text, password.text);

    setState(() {
      token = tokenUserData.token;
      id = tokenUserData.id;
      usernameData = tokenUserData.username;
      emailData = tokenUserData.email;
      passwordData = tokenUserData.password;
    });

    if (token != null) {
      /*Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Home()),
        (route) => false,
      );*/
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/home', (Route<dynamic> route) => false,
          arguments: {
            'id': id,
            'token': token,
            'usernameData': usernameData,
          });
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _recognizerTermsOfService = TapGestureRecognizer()
      ..onTap = () {
        print("terminos de servicio");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TermsOfSerivceWidget()),
        );
      };
    _recognizerPrivacyPolicy = TapGestureRecognizer()
      ..onTap = () {
        print("politicas de privacidad");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrivacyPolicyWidget()),
        );
      };
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
                        hint: "Nombre y Apellido",
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
                    Container(
                      margin: EdgeInsets.only(
                        top: 20.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: backgroundColor,
                      ),
                      padding: EdgeInsets.only(left: 2),
                      child: TextField(
                        controller: password,
                        keyboardType: TextInputType.text,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Contraseña",
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isHidden = !_isHidden;
                                });
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(aceptTOSandPP
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  aceptTOSandPP = !aceptTOSandPP;
                                });
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Al registrarte, estás aceptando las ',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    )),
                                RichText(
                                    text: new TextSpan(
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                        ),
                                        children: <TextSpan>[
                                      new TextSpan(
                                          text: 'Condiciones de Servicio ',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold),
                                          recognizer:
                                              _recognizerTermsOfService),
                                      new TextSpan(
                                        text: 'y las ',
                                      )
                                    ])),
                                RichText(
                                    text: new TextSpan(
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                        ),
                                        children: <TextSpan>[
                                      new TextSpan(
                                          text: 'Políticas de Privacidad',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold),
                                          recognizer: _recognizerPrivacyPolicy),
                                    ]))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 47,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: StadiumBorder(),
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                            onPressed: () {
                              //getValues();
                              //_register();
                              _validationRegister();
                            },
                            child: Text(
                              'Registrarse',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ))),
                    Container(
                      margin: EdgeInsets.only(top: 30),
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
