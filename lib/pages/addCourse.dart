import 'package:flutter/material.dart';
import 'package:speedplanner/utils/AppBar.dart';
//!import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/normalInput.dart';
import 'package:speedplanner/utils/desInput.dart';
import 'package:speedplanner/utils/miniInput.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCourse extends StatefulWidget {
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController nameText = TextEditingController();
  TextEditingController descText = TextEditingController();
  TextEditingController emailText = TextEditingController();

  TextEditingController dayText = TextEditingController();
  TextEditingController startText = TextEditingController();
  TextEditingController finishText = TextEditingController();

  var dayArr = [];
  var startArr = [];
  var finishArr = [];

  void timeString(TextEditingController day, TextEditingController start,
      TextEditingController finish) {
    String dayString, startString, finishString;
    dayString = day.text;
    startString = start.text;
    finishString = finish.text;
    if (dayString == '' || startString == '' || finishString == '') {
      print("efe");
    } else {
      dayArr.add(dayText.text);
      startArr.add(startText.text);
      finishArr.add(finishText.text);
      print("gotcha");
    }
  }

  // create some values
  //Color pickerColor = firstChoice;
  //Color currentColor = firstChoice;

  Color currentColor = Colors.limeAccent;
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

  // ValueChanged<Color> callback
  /*void changeColor(Color color) {
    setState(() => pickerColor = color);
  }*/

  String timeMessage = '';

  timeShow(message) {
    String day, start, finish;
    String day2, start2, finish2;
    String day3, start3, finish3;

    if (dayArr.isEmpty || startArr.isEmpty || finishArr.isEmpty) {
      message = 'No hay cursos disponibles';
    } else if (dayArr.length == 1 &&
        startArr.length == 1 &&
        finishArr.length == 1) {
      day = dayArr[0];
      start = startArr[0];
      finish = finishArr[0];
      message = '$day: $start - $finish\n';
    } else if (dayArr.length == 2 &&
        startArr.length == 2 &&
        finishArr.length == 2) {
      day = dayArr[0];
      start = startArr[0];
      finish = finishArr[0];
      day2 = dayArr[1];
      start2 = startArr[1];
      finish2 = finishArr[1];
      message = '$day: $start - $finish\n'
          '$day2: $start2 - $finish2';
    } else if (dayArr.length == 3 &&
        startArr.length == 3 &&
        finishArr.length == 3) {
      day = dayArr[0];
      start = startArr[0];
      finish = finishArr[0];
      day2 = dayArr[1];
      start2 = startArr[1];
      finish2 = finishArr[1];
      day3 = dayArr[2];
      start3 = startArr[2];
      finish3 = finishArr[2];
      message = '$day: $start - $finish\n'
          '$day2: $start2 - $finish2\n'
          '$day3: $start3 - $finish3';
    }

    return message;
  }

  var urlCourses = Uri.parse(
      'https://speedplanner-mobile.herokuapp.com/api/users/1/courses');

  Future<http.Response> createCourse(name, description, email, color) async {
    http.Response response = await http.post(urlCourses,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJnaW5vIn0.bCcj99sO-yCeKqTfxBEUMinv8ei5EEsSDZy-mG1tjHaE6Z4Pn9YB7bJCrUOaqp-1pV1vXIBiPcNTY7KFWh12Zw'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'description': description,
          'email': email,
          'color': color
        }));
    if (response.statusCode == 200) {
      print("Curso creado: $name");
      for (var i = 0; i < dayArr.length; i++) {
        Map dataCourse = jsonDecode(utf8.decode(response.bodyBytes));
        int idCourse = dataCourse['id'];
        http.Response responseTime = await http.post(
            Uri.parse(
                'https://speedplanner-mobile.herokuapp.com/api/courses/$idCourse/times'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization':
                  'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJnaW5vIn0.bCcj99sO-yCeKqTfxBEUMinv8ei5EEsSDZy-mG1tjHaE6Z4Pn9YB7bJCrUOaqp-1pV1vXIBiPcNTY7KFWh12Zw'
            },
            body: jsonEncode(<String, String>{
              'day': dayArr[i],
              'startTime': startArr[i],
              'finishTime': finishArr[i],
            }));
        if (response.statusCode == 200) {
          print("Tiempo agregado");
          Navigator.pop(context, '/addCourse');
        }
      }
    } else {
      print("Error en la creación");
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    timeMessage = timeShow(timeMessage);
    changeColor(firstChoice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSpeedplanner('Calixto21'),
      body: Container(
        decoration: BoxDecoration(color: Color(0xffE9EBF8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: currentColor,
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Wrap(
                              direction: Axis.horizontal,
                              spacing: 52.0,
                              children: [
                                Text(
                                  'Crear Curso',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Colr del Curso'),
                                          content: SingleChildScrollView(
                                            child: BlockPicker(
                                              pickerColor: currentColor,
                                              onColorChanged: changeColor,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Cambia el color!'),
                                  style: ElevatedButton.styleFrom(
                                    primary: currentColor,
                                    side: BorderSide(
                                      width: 4.0,
                                      color: backgroundColor,
                                    ),
                                    textStyle: TextStyle(
                                      color: useWhiteForeground(currentColor)
                                          ? const Color(0xffffffff)
                                          : const Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
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
                            normalInput(controller: nameText),
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
                            desInput(controller: descText),
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
                            normalInput(controller: emailText),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Agregar horario (máx. 3)',
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
                                miniInput(controller: dayText, hint: "Día"),
                                miniInput(
                                    controller: startText, hint: "Hora ini."),
                                miniInput(
                                    controller: finishText, hint: "Hora fin."),
                                FloatingActionButton(
                                  heroTag: "btn2",
                                  backgroundColor: Color(0x00000000),
                                  elevation: 0,
                                  mini: true,
                                  onPressed: () {
                                    timeString(dayText, startText, finishText);
                                    setState(() {
                                      timeMessage = timeShow(timeMessage);
                                    });
                                    dayText.clear();
                                    startText.clear();
                                    finishText.clear();
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
              color: currentColor,
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
                            timeMessage,
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
                        heroTag: "btn3",
                        elevation: 0,
                        onPressed: () {
                          // Add your onPressed code here!
                          String colorString =
                              currentColor.toString(); // Color(0x12345678)
                          String valueString =
                              colorString.split('(0x')[1].split(')')[0];
                          //print('0x$valueString');
                          createCourse(nameText.text, descText.text,
                              emailText.text, '0x$valueString');
                        },
                        label: const Text('Crear Curso'),
                        backgroundColor: backgroundColor,
                        foregroundColor: currentColor,
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 35),
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
