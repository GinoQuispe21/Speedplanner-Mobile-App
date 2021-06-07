import 'package:flutter/cupertino.dart';
import 'package:speedplanner/utils/colors.dart';

Widget footer({context}) {
  return Container(
    color: backgroundColor,
    height: MediaQuery.of(context).size.height * 0.10,
    width: MediaQuery.of(context).size.width,
    child:
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        'Un producto hecho por',
        style: TextStyle(fontSize: 13),
      ),
      Image(
          image: AssetImage('assets/fasttech_logo.png'),
          width: 100,
          height: 30),
      Text(
        '©2021',
        style: TextStyle(fontSize: 13),
      )
    ]),
  );
}
