import 'package:flutter/material.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';

class TaskDetails extends StatefulWidget {
  final int id;
  final String token;
  final String username;
  final int courseId;

  const TaskDetails(
      {this.id, this.token, this.username, this.courseId, Key key})
      : super(key: key);

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarSpeedplanner('${widget.username}'),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(color: Color(0xffE9EBF8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 85),
                  child: Container(
                      color: dateBG,
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.only(left: 35, right: 35, top: 5),
                        child: Row(
                          children: <Widget>[
                            Container(),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(top: 2, bottom: 2),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration:
                                    BoxDecoration(color: Color(0xffD7DAEB)),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  'Date: 21 de Abril del 2021',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xff8377D1),
                                      fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )))
            ],
          ),
        ));
  }
}
