import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedplanner/utils/colors.dart';

Widget miniInput({controller, hint}) {
  return Container(
    width: 91.0,
    //height: 45.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: backgroundColor,
    ),
    //padding: EdgeInsets.only(left: 2),
    child: TextFormField(
      controller: controller,
      //keyboardType: TextInputType.number,
      maxLength: 5,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9:]')),
      ],
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
      ),
    ),
  );
}
