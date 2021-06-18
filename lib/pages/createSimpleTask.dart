import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/models/SimpleTask.dart';
import 'package:speedplanner/models/StudyGroup.dart';
import 'package:speedplanner/services/CreateSimpleTask.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/dateFooter.dart';

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
  DateTime selectedDate = DateTime.now();
  String _selectedTime;
  List<String> entries = <String>['Mi grupo personal', 'TeamMatch', 'FastTech'];
  int selectedRadioTile;
  TextEditingController titleTask = TextEditingController();
  TextEditingController descriptionTask = TextEditingController();
  String deadline = '';
  bool finished = false;

  void _createSimpleTask() async {
    SimpleTask simpleTask = await createSimpleTaskService.createSimpleTask(
        widget.listGroup[0],
        widget.token,
        titleTask.text,
        descriptionTask.text,
        "2021-07-02T10:00:00.000+00:00",
        false);
  }

  Future<void> _show() async {
    final TimeOfDay result = await showTimePicker(
        context: context,
        helpText: 'Seleccione la hora:',
        cancelText: 'Cancelar',
        confirmText: 'Aceptar',
        initialTime: TimeOfDay.now(),
        builder: (context, _) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: false),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    // change the border color
                    primary: Color(0xff30B18B),
                    // change the text color
                    onSurface: Color(0xff8377D1),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(primary: Colors.blue[300]),
                  ),
                  // button colors
                  buttonTheme: ButtonThemeData(
                    colorScheme: ColorScheme.light(
                      primary: Colors.green,
                    ),
                  ),
                ),
                child: _,
              ));
        });
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        helpText: 'Seleccione la fecha:',
        cancelText: 'Cancelar',
        confirmText: 'Aceptar',
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xff30B18B), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(primary: Colors.blue[300]),
              ),
              dialogBackgroundColor: Color(0XffE9EBF8),
            ),
            child: child,
          );
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void getCurrentDate() async {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
    getCurrentDate();
    print(widget.token);
    print('${widget.listGroup[0].id} - ${widget.listGroup[0].name}');
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
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 50.0),
                  child: Container(
                    //decoration: BoxDecoration(color: Color(0xffC7C1EB)),
                    width: size.width,
                    height: size.height / 1.35,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    ElevatedButton.icon(
                                      label: Text("Elegir Fecha"),
                                      onPressed: () => _selectDate(context),
                                      icon: Icon(Icons.date_range_outlined),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff8377D1),
                                          shape: StadiumBorder(),
                                          side: BorderSide(
                                              color: Colors.white, width: 2),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 7),
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Text("Fecha seleccionada:"),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${selectedDate.toLocal()}"
                                              .split(' ')[0],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xff8E8E8E)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    ElevatedButton.icon(
                                        label: Text("Elegir Hora"),
                                        onPressed: _show,
                                        icon: Icon(Icons.timer_rounded),
                                        style: ElevatedButton.styleFrom(
                                            primary: Color(0xff8377D1),
                                            shape: StadiumBorder(),
                                            side: BorderSide(
                                                color: Colors.white, width: 2),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 13, vertical: 7),
                                            textStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold))),
                                    Text("Hora seleccionada:"),
                                    Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            _selectedTime != null
                                                ? _selectedTime
                                                : '00:00 AM',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff8E8E8E)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 7),
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
                                    itemCount: entries.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 40,
                                        child: RadioListTile(
                                          value: index,
                                          groupValue: selectedRadioTile,
                                          onChanged: (val) {
                                            print("Radio Tile pressed $val");
                                            setSelectedRadioTile(val);
                                          },
                                          activeColor: Color(0xff8980D3),
                                          title: Text(
                                            "${entries[index]}",
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
