import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';

Widget normalInput({controller}) {
  return Container(
    height: 35.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: backgroundColor,
    ),
    padding: EdgeInsets.only(left: 7),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    ),
  );
}
