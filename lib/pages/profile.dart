import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/Services/ProfileService.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speedplanner/Services/UserService.dart';

enum Gender { male, female, others }

//TODO: Alert Dialogs para campos vacíos
//TODO: Quitar SizedBox del final, alinear widget de fecha abajo

class Profile extends StatefulWidget {
  final int id;
  final String token;

  const Profile({this.id, this.token, Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserService userService = new UserService();
  ProfileService profileService = new ProfileService();

  Gender _gender;
  Gender gValue;
  String formatter = '';
  bool fieldsEnabled = false;
  String editBtnText = 'Editar Perfil';
  String title = 'Perfil';

  var userTxt = TextEditingController();
  var nameTxt = TextEditingController();
  var emailTxt = TextEditingController();
  var ageTxt = TextEditingController();

  void getDate() {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  void getUserData() async {
    await userService.getUserData(widget.id, widget.token);
    userTxt.text = userService.user;
    emailTxt.text = userService.email;
  }

  void getProfileData() async {
    await profileService.getProfileData(widget.id, widget.token);
    nameTxt.text = profileService.name;
    ageTxt.text = profileService.age.toString();
    setGender();
  }

  @override
  void initState() {
    super.initState();
    getDate();
    getProfileData();
    getUserData();
  }

  void toggleEditing() {
    setState(() {
      fieldsEnabled = !fieldsEnabled;

      if (editBtnText == 'Editar Perfil') {
        editBtnText = 'Guardar Cambios';
      } else {
        editBtnText = 'Editar Perfil';
      }

      if (title == 'Perfil') {
        title = 'Editar Perfil';
      } else {
        title = 'Perfil';
      }
    });
  }

  void setGender() {
    setState(() {
      switch (profileService.gender.toLowerCase()) {
        case "masculino":
          {
            _gender = Gender.male;
            print("masculino encontrado");
          }
          break;
        case "femenino":
          {
            _gender = Gender.female;
          }
          break;
        case "others":
          {
            _gender = Gender.others;
          }
          break;
      }
    });
  }

  void updateGender() {
    switch (_gender) {
      case Gender.male:
        {
          profileService.putGender = "Masculino";
        }
        break;
      case Gender.female:
        {
          profileService.putGender = "Femenino";
        }
        break;
      case Gender.others:
        {
          profileService.putGender = "Others";
        }
        break;
    }
  }

  void updateFields() async {
    userService.putUser = userTxt.text;
    userService.putEmail = emailTxt.text;
    profileService.putName = nameTxt.text;
    profileService.putAge = ageTxt.text;
    updateGender();

    await userService.updateUserData(widget.id, widget.token);
    await profileService.updateProfileData(widget.id, widget.token);
  }

  bool anyFieldEmpty() {
    return userTxt.text.isEmpty ||
        nameTxt.text.isEmpty ||
        emailTxt.text.isEmpty ||
        ageTxt.text.isEmpty ||
        _gender == null;
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            titlePadding: EdgeInsets.all(20),
            content: Container(
              child: Text('No deje espacios vacíos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
            ),
            contentPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: alert,
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                    child: Text(
                      'Aceptar',
                      style: TextStyle(
                          color: purpleColor,
                          fontSize: 16,
                          fontStyle: FontStyle.italic),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.fromLTRB(30, 15, 30, 15)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: alert)))),
                    onPressed: () => Navigator.pop(context)),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: purpleColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: Text('User',
                          style: TextStyle(
                            color: purpleColor,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          )),
                    )
                  ]),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextField(
                      controller: userTxt,
                      enabled: fieldsEnabled,
                      style: TextStyle(
                          color: textFieldColor,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.all(16.0),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide:
                                BorderSide(style: BorderStyle.none, width: 0)),
                      ),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: Text('Email',
                          style: TextStyle(
                            color: purpleColor,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          )),
                    )
                  ]),

                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextField(
                        controller: emailTxt,
                        enabled: fieldsEnabled,
                        style: TextStyle(
                            color: textFieldColor,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(16.0),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide(
                                  style: BorderStyle.none, width: 0)),
                        ),
                      )),

                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: Text('Name',
                          style: TextStyle(
                            color: purpleColor,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          )),
                    )
                  ]),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextField(
                      controller: nameTxt,
                      enabled: fieldsEnabled,
                      style: TextStyle(
                          color: textFieldColor,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.all(16.0),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide:
                                BorderSide(style: BorderStyle.none, width: 0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34),
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            color: purpleColor,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        )),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Theme(
                              data: ThemeData(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent),
                              child: RadioListTile<Gender>(
                                activeColor: purpleColor,
                                title: Text(
                                  'Male',
                                  style: TextStyle(
                                      color: purpleColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                                value: Gender.male,
                                groupValue: _gender,
                                onChanged: (Gender value) {
                                  setState(() {
                                    if (fieldsEnabled) _gender = value;
                                  });
                                },
                              ))),
                      Flexible(
                          child: Theme(
                        data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent),
                        child: RadioListTile<Gender>(
                          activeColor: purpleColor,
                          contentPadding: EdgeInsets.only(right: 10),
                          title: Text(
                            'Female',
                            style: TextStyle(
                                color: purpleColor,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          value: Gender.female,
                          groupValue: _gender,
                          onChanged: (Gender value) {
                            setState(() {
                              if (fieldsEnabled) _gender = value;
                            });
                          },
                        ),
                      )),
                      Flexible(
                          child: Theme(
                              data: ThemeData(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent),
                              child: RadioListTile<Gender>(
                                activeColor: purpleColor,
                                contentPadding: EdgeInsets.only(right: 15),
                                title: Text(
                                  'Others',
                                  style: TextStyle(
                                      color: purpleColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                                value: Gender.others,
                                groupValue: _gender,
                                onChanged: (Gender value) {
                                  setState(() {
                                    if (fieldsEnabled) _gender = value;
                                  });
                                },
                              ))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(34, 0, 20, 0),
                        child: Text(
                          'Age',
                          style: TextStyle(
                              color: purpleColor,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        child: TextField(
                          controller: ageTxt,
                          enabled: fieldsEnabled,
                          style: TextStyle(
                              color: textFieldColor,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.all(16.0),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      child: Text(
                        editBtnText,
                        style: TextStyle(
                            color: purpleColor,
                            fontSize: 16,
                            fontStyle: FontStyle.italic),
                      ),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.fromLTRB(30, 15, 30, 15)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all(0),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: purpleColor)))),
                      onPressed: () {
                        if (fieldsEnabled) {
                          toggleEditing();
                          if (anyFieldEmpty()) {
                            print('campo(s) vacíos');
                            _showDialog();
                          } else {
                            print('actualizando...');
                            updateFields();
                          }
                        } else {
                          toggleEditing();
                          print('se puede editar');
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
//Inicio de footer
                  Row(
                    children: <Widget>[
                      dateFooter(
                          context: context, currentDate: 'Date: ' + formatter),
                    ],
                  )
                ]),
          )),
    );
  }
}
