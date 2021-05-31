import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

enum Gender { male, female, others }

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Gender? _gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child:
          ListView(padding: EdgeInsets.symmetric(horizontal: 24.0), children: <
              Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          SizedBox(height: 50),
          Text(
            'Perfil',
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
            Text('User',
                style: TextStyle(
                  color: purpleColor,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ))
          ]),
          TextField(
            style: TextStyle(
                color: greyColor,
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
                  borderSide: BorderSide(style: BorderStyle.none, width: 0)),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text('Email',
                style: TextStyle(
                  color: purpleColor,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ))
          ]),
          TextField(
            style: TextStyle(
                color: greyColor,
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
                  borderSide: BorderSide(style: BorderStyle.none, width: 0)),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text('Name',
                style: TextStyle(
                  color: purpleColor,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ))
          ]),
          TextField(
            style: TextStyle(
                color: greyColor,
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
                  borderSide: BorderSide(style: BorderStyle.none, width: 0)),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Gender',
                style: TextStyle(
                  color: purpleColor,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                  child: RadioListTile<Gender>(
                contentPadding: EdgeInsets.zero,
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
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              )),
              Flexible(
                  child: RadioListTile<Gender>(
                contentPadding: EdgeInsets.zero,
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
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              )),
              Flexible(
                  child: RadioListTile<Gender>(
                contentPadding: EdgeInsets.zero,
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
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Age',
                style: TextStyle(
                    color: purpleColor,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              TextField(
                style: TextStyle(
                    color: greyColor,
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
              )
            ],
          ),
        ])
      ]),
    ));
  }
}
