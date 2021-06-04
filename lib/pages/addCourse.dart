import 'package:flutter/material.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/normalInput.dart';
import 'package:speedplanner/utils/desInput.dart';
import 'package:speedplanner/utils/miniInput.dart';

class AddCourse extends StatefulWidget {
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(color: Color(0xffE9EBF8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: firstChoice,
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Crear Curso',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Nombre del curso',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            normalInput(),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Descripción (100 car. máx)',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            desInput(),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Correo del Docente',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            normalInput(),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Agregar horario',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            Wrap(
                              direction: Axis.horizontal,
                              spacing: 5.0,
                              children: [
                                miniInput(),
                                miniInput(),
                                miniInput(),
                                FloatingActionButton(
                                  backgroundColor: Color(0x00000000),
                                  elevation: 0,
                                  mini: true,
                                  onPressed: () {
                                    print("yes");
                                  },
                                  child: const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Color(0xfffffffff),
                                    size: 40.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Horarios de Clase',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Container(
              color: firstChoice,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 35, bottom: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        child: Container(
                          child: Text(
                            'No hay horarios para este curso',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      FloatingActionButton.extended(
                        elevation: 0,
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        label: const Text('Crear Curso'),
                        backgroundColor: backgroundColor,
                        foregroundColor: firstChoice,
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 45),
              child: Container(
                  color: dateBG,
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.only(left: 35, right: 35, top: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 2),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Color(0xffD7DAEB)),
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
                  )),
            )
          ],
        ),
      ),
    );
  }
}
