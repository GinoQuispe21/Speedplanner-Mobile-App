import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/models/SimpleTask.dart';
import 'package:speedplanner/models/StudyGroup.dart';
import 'package:speedplanner/services/CreateSimpleTask.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:speedplanner/utils/showDialogSchedule.dart';

class CreateSimpleTask extends StatefulWidget {
  final String token;
  final String username;
  final List<StudyGroup> listGroup;
  const CreateSimpleTask({this.token, this.username, this.listGroup, Key key})
      : super(key: key);

  @override
  _CreateSimpleTaskState createState() => _CreateSimpleTaskState();
}

class _CreateSimpleTaskState extends State<CreateSimpleTask> {
  CreateSimpleTaskService createSimpleTaskService =
      new CreateSimpleTaskService();
  String formatter = '';
  List<StudyGroup> listGroups = [];
  int selectedRadioTile;
  TextEditingController titleTask = TextEditingController();
  TextEditingController descriptionTask = TextEditingController();
  String deadline = '';
  bool finished = false;
  String timeAux;

  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');

  void _createSimpleTask() async {
    if (titleTask.text != '' &&
        descriptionTask.text != '' &&
        selectedRadioTile != null) {
      var aux = selectedDate.toString();
      String date = aux.substring(0, 16);
      TestSimpleTask simpleTask =
          await createSimpleTaskService.createSimpleTask(selectedRadioTile,
              widget.token, titleTask.text, descriptionTask.text, date, false);
      if (simpleTask.deadline == "2021-07-02T10:00:00.000+00:00") {
        print("TAREA CREADA DE VERDAD");
        print(simpleTask.title);
      }
    } else {
      print("ERROR");
    }
  }

  void getCurrentDate() async {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      print(
          "El id de grupo que va a ser referenciado para crear es: $selectedRadioTile");
    });
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
        appBar: appBarSpeedplanner('${widget.username}'),
        body: Container(
            height: size.height,
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xffE9EBF8)),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    //decoration: BoxDecoration(color: Color(0xffC7C1EB)),
                    width: size.width,
                    height: size.height / 1.40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text("Nueva Tarea Simple",
                              style: TextStyle(
                                color: Color(0xff8980D3),
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              )),
                        ),
                        SizedBox(height: 10),
                        Text('Titulo',
                            style: TextStyle(
                              color: Color(0xff8980D3),
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
                        SizedBox(height: 7),
                        Text('Descripción',
                            style: TextStyle(
                              color: Color(0xff8980D3),
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
                        SizedBox(height: 7),
                        Text('Deadline',
                            style: TextStyle(
                              color: Color(0xff8980D3),
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 3),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: ElevatedButton.icon(
                                  label: Text("Fecha y Hora"),
                                  onPressed: () async {
                                    showDateTimeDialog(context,
                                        initialDate: selectedDate,
                                        onSelectedDate: (selectedDate) {
                                      setState(() {
                                        this.selectedDate = selectedDate;
                                        print(
                                            'LA HORA ES:  ${selectedDate.toString()}');
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.calendar_today_outlined),
                                  style: ElevatedButton.styleFrom(
                                      primary: purpleColor,
                                      shape: StadiumBorder(),
                                      side: BorderSide(
                                          color: Colors.white, width: 2),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 7),
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              flex: 4,
                            ),
                            Expanded(
                              child: Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            right: 13,
                                            left: 13),
                                        child: Text(
                                          dateFormat.format(selectedDate),
                                          style: TextStyle(
                                              color: Color(0xff737373),
                                              fontSize: 14),
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                                          padding:
                                              const EdgeInsets.only(right: 10),
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
                ),
                Positioned(
                    bottom: 0,
                    child: dateFooter(
                        context: context, currentDate: 'Date: ' + formatter))
              ],
            )));
  }
}
