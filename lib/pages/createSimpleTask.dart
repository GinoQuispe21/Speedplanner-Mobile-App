import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:speedplanner/models/TimedTask.dart';
import 'package:speedplanner/models/SimpleTask.dart';
import 'package:speedplanner/models/StudyGroup.dart';
import 'package:speedplanner/services/CreateSimpleTask.dart';
import 'package:speedplanner/services/CreateTimedTask.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:speedplanner/utils/showDialogSchedule.dart';
import 'package:speedplanner/pages/addGroup.dart';

class CreateSimpleTask extends StatefulWidget {
  final String token;
  final String username;
  final List<StudyGroup> listGroup;
  final int courseId;
  final String courseName;
  const CreateSimpleTask(
      {this.token,
      this.username,
      this.listGroup,
      this.courseId,
      this.courseName,
      Key key})
      : super(key: key);

  @override
  _CreateSimpleTaskState createState() => _CreateSimpleTaskState();
}

class _CreateSimpleTaskState extends State<CreateSimpleTask> {
  CreateSimpleTaskService createSimpleTaskService =
      new CreateSimpleTaskService();
  CreateTimedTaskService createTimedTaskService = new CreateTimedTaskService();
  String formatter = '';
  List<StudyGroup> listGroups = [];
  int selectedRadioTile;
  TextEditingController titleTask = TextEditingController();
  TextEditingController descriptionTask = TextEditingController();
  String deadline = '';
  bool finished = false;
  bool isTimedTask = false;
  bool sure = false;
  String timeAux;

  DateTime selectedDateStart = DateTime.now();
  final DateFormat dateFormatStart = DateFormat('yyyy-MM-dd HH:mm');

  DateTime selectedDateEnd = DateTime.now();
  final DateFormat dateFormatEnd = DateFormat('yyyy-MM-dd HH:mm');

  _openPopUpError(context) {
    Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: Color(0xffF87575),
          descStyle: TextStyle(color: Colors.white, fontSize: 15),
          titleStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        title: "Error",
        desc:
            "No se pudo crear la tarea, verifique que haya completado todos los campos",
        buttons: [
          DialogButton(
              child: Text(
                "Aceptar",
                style: TextStyle(color: Color(0xffF87575), fontSize: 17),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.white),
        ]).show();
  }

  _openPopUpAreYouSure(context) {
    Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: backgroundColor,
          descStyle: TextStyle(color: Color(0xff707070), fontSize: 15),
          titleStyle: TextStyle(
              color: purpleColor, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        title: "Confirmación",
        desc: "Esta registrando la tarea:",
        content: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Titulo de la Tarea: ",
                  style: TextStyle(fontSize: 15, color: Color(0xff707070)),
                ),
                Text(
                  '${titleTask.text}',
                  style: TextStyle(fontSize: 15, color: Color(0xff707070)),
                ),
                Divider(
                  height: 20.0,
                  thickness: 1.5,
                  color: Color(0Xff707070),
                ),
                Text(
                  "Descripción de la Tarea: ",
                  style: TextStyle(fontSize: 15, color: Color(0xff707070)),
                ),
                Text(
                  '${descriptionTask.text}',
                  style: TextStyle(fontSize: 15, color: Color(0xff707070)),
                ),
                Divider(
                  height: 20.0,
                  thickness: 1.5,
                  color: Color(0Xff707070),
                ),
                Row(
                  children: <Widget>[
                    Text("Inicio: ",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff707070))),
                    Text(dateFormatStart.format(selectedDateStart),
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff707070)))
                  ],
                ),
                Container(
                  child: isTimedTask
                      ? Divider(
                          height: 20.0,
                          thickness: 1.5,
                          color: Color(0Xff707070),
                        )
                      : null,
                ),
                Container(
                  child: isTimedTask
                      ? Row(
                          children: <Widget>[
                            Text("Final: ",
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff707070))),
                            Text(dateFormatEnd.format(selectedDateEnd),
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xff707070)))
                          ],
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
        buttons: [
          DialogButton(
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.grey[400]),
          DialogButton(
            child: Text(
              "Aceptar",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            onPressed: () {
              if (isTimedTask == false) {
                print("ACA SE VA A CREAR UNA TAREA SIMPLE");
                _createSimpleTask();
                Navigator.pop(context);
              }
              if (isTimedTask == true) {
                print("ACA SE VA A CREAR UNA TAREA CRONOMETRADA");
                _createTimedTasks();
                Navigator.pop(context);
              }
            },
            color: purpleColor,
          )
        ]).show();
  }

  void createTask() {
    if (titleTask.text == '' ||
        descriptionTask.text == '' ||
        selectedRadioTile == null) {
      _openPopUpError(context);
    } else {
      _openPopUpAreYouSure(context);
    }
  }

  void _createSimpleTask() async {
    var aux = selectedDateStart.toString();
    String date = aux.substring(0, 16);
    TestSimpleTask simpleTask = await createSimpleTaskService.createSimpleTask(
        selectedRadioTile,
        widget.token,
        titleTask.text,
        descriptionTask.text,
        date,
        false);
    print("TAREA CREADA DE VERDAD");
    Fluttertoast.showToast(
        msg: "Tarea creada",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff30B18B),
        textColor: Colors.white,
        fontSize: 16.0);
    print(simpleTask.title);
  }

  void _createTimedTasks() async {
    var aux1 = selectedDateStart.toString();
    String dateStart = aux1.substring(0, 16);
    var aux2 = selectedDateEnd.toString();
    String dateEnd = aux2.substring(0, 16);
    TestTimedTask testTimedTask = await createTimedTaskService.createTimedTask(
        selectedRadioTile,
        widget.token,
        titleTask.text,
        descriptionTask.text,
        dateStart,
        dateEnd,
        finished);
    print("TAREA CREADA DE VERDAD");
    Fluttertoast.showToast(
        msg: "Tarea creada",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff30B18B),
        textColor: Colors.white,
        fontSize: 16.0);
    print(testTimedTask.title);
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
        appBar: appBarSpeedplanner(context, '${widget.username}'),
        body: Container(
            height: size.height,
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xffE9EBF8)),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 60.0),
                  child: Container(
                    //decoration: BoxDecoration(color: Color(0xffC7C1EB)),
                    width: size.width,
                    height: size.height / 1.40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text("Nueva Tarea",
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
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            IconButton(
                              color: Color(0xff707070),
                              icon: Icon(isTimedTask
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank_outlined),
                              onPressed: () {
                                setState(() {
                                  isTimedTask = !isTimedTask;
                                });
                              },
                            ),
                            Text("Asignar hora limite a la tarea")
                          ],
                        ),
                        Text('Inicio',
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
                                          dateFormatStart
                                              .format(selectedDateStart),
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
                        Container(
                          child: isTimedTask
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Final',
                                        style: TextStyle(
                                          color: Color(0xff8980D3),
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
                                                    initialDate:
                                                        selectedDateEnd,
                                                    onSelectedDate:
                                                        (selectedDate) {
                                                  setState(() {
                                                    this.selectedDateEnd =
                                                        selectedDate;
                                                    print(
                                                        'LA HORA ES:  ${selectedDate.toString()}');
                                                  });
                                                });
                                              },
                                              icon: Icon(Icons
                                                  .calendar_today_outlined),
                                              style: ElevatedButton.styleFrom(
                                                  primary: purpleColor,
                                                  shape: StadiumBorder(),
                                                  side: BorderSide(
                                                      color: Colors.white,
                                                      width: 2),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 7),
                                                  textStyle: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          flex: 4,
                                        ),
                                        Expanded(
                                          child: Center(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10,
                                                            right: 13,
                                                            left: 13),
                                                    child: Text(
                                                      dateFormatEnd.format(
                                                          selectedDateEnd),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff737373),
                                                          fontSize: 14),
                                                    ),
                                                  ))),
                                          flex: 5,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : null,
                        ),
                        Text('Grupo',
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
                                height: 40.0 * listGroups.length,
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
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddGroup(
                                                          courseId:
                                                              widget.courseId,
                                                          token: widget.token,
                                                          username:
                                                              widget.username,
                                                          courseName:
                                                              widget.courseName,
                                                        )));
                                          },
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
                                    //_createSimpleTask();
                                    createTask();
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
