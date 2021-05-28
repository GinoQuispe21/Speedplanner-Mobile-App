import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

Widget textInput({controller, hint, icon, top}) {
  return Container(
    margin: EdgeInsets.only(top: top),
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
