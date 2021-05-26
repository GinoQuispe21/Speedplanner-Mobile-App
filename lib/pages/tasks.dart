import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color(0xffE9EBF8)),
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text('No hay tareas registradas'),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(color: Color(0xffD7DAEB)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Date: 21 de Abril del 2021',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff8377D1),
                                    fontSize: 15,
                                    fontFamily: 'Montserrat',
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        )))
              ],
            )
          ],
        )));
  }
}
