import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

Widget desInput({controller}) {
  return Container(
    height: 75.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: backgroundColor,
    ),
    padding: EdgeInsets.only(left: 2),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    ),
  );
}
