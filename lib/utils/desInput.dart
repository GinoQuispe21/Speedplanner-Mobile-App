import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

Widget desInput({controller}) {
  return Container(
    height: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: backgroundColor,
    ),
    padding: EdgeInsets.only(left: 5),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    ),
  );
}
