import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:speedplanner/models/StudyGroup.dart';
import 'package:speedplanner/models/TimedTask.dart';
import 'package:speedplanner/services/CreateSimpleTask.dart';
import 'package:speedplanner/services/CreateTimedTask.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:speedplanner/utils/showDialogSchedule.dart';

class CreateTimedTask extends StatefulWidget {
  final String token;
  final String username;
  final List<StudyGroup> listGroup;
  const CreateTimedTask({this.token, this.username, this.listGroup, Key key})
      : super(key: key);

  @override
  _CreateTimedTaskState createState() => _CreateTimedTaskState();
}

class _CreateTimedTaskState extends State<CreateTimedTask> {
  CreateTimedTaskService createTimedTaskService = new CreateTimedTaskService();

  String formatter = '';
  TextEditingController titleTask = TextEditingController();
  TextEditingController descriptionTask = TextEditingController();
  List<StudyGroup> listGroups = [];
  int selectedRadioTile;
  bool finished = false;

  DateTime selectedDateStart = DateTime.now();
  final DateFormat dateFormatStart = DateFormat('yyyy-MM-dd HH:mm');

  DateTime selectedDateEnd = DateTime.now();
  final DateFormat dateFormatEnd = DateFormat('yyyy-MM-dd HH:mm');

  void _createSimpleTask() async {
    if (titleTask.text != '' &&
        descriptionTask.text != '' &&
        selectedRadioTile != null) {
      var aux1 = selectedDateStart.toString();
      String dateStart = aux1.substring(0, 16);

      var aux2 = selectedDateStart.toString();
      String dateEnd = aux2.substring(0, 16);

      TestTimedTask testTimedTask =
          await createTimedTaskService.createTimedTask(
              selectedRadioTile,
              widget.token,
              titleTask.text,
              descriptionTask.text,
              dateStart,
              dateEnd,
              finished);

      print("TAREA CREADA DE VERDAD");
      print(testTimedTask.title);
    } else {
      print("ERROR");
    }
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      print(
          "El id de grupo que va a ser referenciado para crear es: $selectedRadioTile");
    });
  }

  void getCurrentDate() async {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  @override
  void initState() {
    super.initState();
    getCurrentDate();
    listGroups = widget.listGroup;
    print(selectedRadioTile);
    for (int i = 0; i < listGroups.length; i++) {
      print(
          "Lista de grupos creada: ${listGroups[i].name} - ${listGroups[i].id}");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarSpeedplanner('hola'),
      body: Container(
        height: size.height,
        width: double.infinity,
        decoration: BoxDecoration(color: backgroundColor),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: 20,
                child: Text(
                  "Nueva Tarea Cronometrada",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: greenColor),
                )),
            Container(
              width: size.width * 0.90,
              height: size.height / 1.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Titulo',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      )),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 10, top: 15),
                    child: TextFormField(
                      controller: titleTask,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Titulo de la nueva tarea',
                          hintStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('Descripción',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      )),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: descriptionTask,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Descripción del curso',
                          hintStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('Comienzo',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      )),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: ElevatedButton.icon(
                            label: Text("Fecha y Hora"),
                            onPressed: () async {
                              showDateTimeDialog(context,
                                  initialDate: selectedDateStart,
                                  onSelectedDate: (selectedDate) {
                                setState(() {
                                  this.selectedDateStart = selectedDate;
                                  print(
                                      'LA HORA ES:  ${selectedDate.toString()}');
                                });
                              });
                            },
                            icon: Icon(Icons.calendar_today_outlined),
                            style: ElevatedButton.styleFrom(
                                primary: purpleColor,
                                shape: StadiumBorder(),
                                side: BorderSide(color: Colors.white, width: 2),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 7),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Center(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 13, left: 13),
                                  child: Text(
                                    dateFormatStart.format(selectedDateStart),
                                    style: TextStyle(
                                        color: Color(0xff737373), fontSize: 14),
                                  ),
                                ))),
                        flex: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Final',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      )),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: ElevatedButton.icon(
                            label: Text("Fecha y Hora"),
                            onPressed: () async {
                              showDateTimeDialog(context,
                                  initialDate: selectedDateEnd,
                                  onSelectedDate: (selectedDate) {
                                setState(() {
                                  this.selectedDateEnd = selectedDate;
                                  print(
                                      'LA HORA ES:  ${selectedDate.toString()}');
                                });
                              });
                            },
                            icon: Icon(Icons.calendar_today_outlined),
                            style: ElevatedButton.styleFrom(
                                primary: purpleColor,
                                shape: StadiumBorder(),
                                side: BorderSide(color: Colors.white, width: 2),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 7),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Center(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 13, left: 13),
                                  child: Text(
                                    dateFormatEnd.format(selectedDateEnd),
                                    style: TextStyle(
                                        color: Color(0xff737373), fontSize: 14),
                                  ),
                                ))),
                        flex: 5,
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text('Seleccionar grupo',
                      style: TextStyle(
                        color: Color(0xff8980D3),
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 130,
                          child: ListView.builder(
                              itemCount: listGroups.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 40,
                                  child: RadioListTile(
                                    value: listGroups[index].id,
                                    groupValue: selectedRadioTile,
                                    onChanged: (val) {
                                      print(
                                          "Radio Tile pressed ${listGroups[index].id}");
                                      setSelectedRadioTile(
                                          listGroups[index].id);
                                    },
                                    activeColor: Color(0xff8980D3),
                                    title: Text(
                                      "${listGroups[index].name}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      "Crear Grupo",
                                      style: TextStyle(
                                        color: Color(0xff8980D3),
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  FloatingActionButton(
                                    mini: true,
                                    heroTag: "btn4",
                                    backgroundColor: Color(0x00000000),
                                    elevation: 0,
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.add_circle_outline_sharp,
                                      color: Color(0xff8980D3),
                                      size: 40.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        flex: 3,
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: StadiumBorder(),
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  color: Color(0xff8377D1), width: 1),
                            ),
                            onPressed: () {
                              _createSimpleTask();
                            },
                            child: Text(
                              'Crear Tarea',
                              style: TextStyle(
                                  color: Color(0xff8377D1),
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic),
                            ))),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: dateFooter(
                    context: context, currentDate: 'Date: ' + formatter))
          ],
        ),
      ),
    );
  }
}
