import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

Widget miniInput({controller, hint}) {
  return Container(
    width: 75.0,
    //height: 30.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: backgroundColor,
    ),
    padding: EdgeInsets.only(left: 2),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
      ),
    ),
  );
}
