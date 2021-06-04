import 'package:flutter/material.dart';

Widget dateFooter({context, currentDate}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(color: Color(0xffD7DAEB)),
    padding: EdgeInsets.symmetric(vertical: 15),
    child: Text(
      currentDate,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color(0xff8377D1),
          fontSize: 15,
          fontFamily: 'Montserrat',
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
    ),
  );
}
