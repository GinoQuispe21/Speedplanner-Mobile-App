import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

Widget emptyFieldsDialog({context}) {
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
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: alert)))),
            onPressed: () => Navigator.pop(context)),
      )
    ],
  );
}
