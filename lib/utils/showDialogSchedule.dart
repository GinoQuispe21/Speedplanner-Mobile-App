import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/utils/colors.dart';

Dialog showDateTimeDialog(
  BuildContext context, {
  @required ValueChanged<DateTime> onSelectedDate,
  @required DateTime initialDate,
}) {
  final dialog = Dialog(
    child: DateTimeDialog(
        onSelectedDate: onSelectedDate, initialDate: initialDate),
  );

  showDialog(context: context, builder: (BuildContext context) => dialog);
}

class DateTimeDialog extends StatefulWidget {
  final ValueChanged<DateTime> onSelectedDate;
  final DateTime initialDate;

  const DateTimeDialog({
    @required this.onSelectedDate,
    @required this.initialDate,
    Key key,
  }) : super(key: key);
  @override
  _DateTimeDialogState createState() => _DateTimeDialogState();
}

class _DateTimeDialogState extends State<DateTimeDialog> {
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Fecha de Tarea Simple',
              style: TextStyle(
                fontSize: 20,
                color: purpleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Ingresar fecha"),
                      ElevatedButton(
                          child: Text(
                              DateFormat('yyyy-MM-dd').format(selectedDate)),
                          onPressed: () async {
                            final date = await _selectDateTime(context);
                            if (date == null) return;
                            setState(() {
                              selectedDate = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  selectedDate.hour,
                                  selectedDate.minute);
                            });
                            widget.onSelectedDate(selectedDate);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: purpleColor,
                          )),
                      //const SizedBox(width: 8),
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("Ingresar hora"),
                      ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child:
                                Text(DateFormat('HH-mm').format(selectedDate)),
                          ),
                          onPressed: () async {
                            final time = await _selectTime(context);
                            if (time == null) return;
                            setState(() {
                              selectedDate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  time.hour,
                                  time.minute);
                            });
                            widget.onSelectedDate(selectedDate);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: purpleColor,
                          ))
                    ],
                  ),
                  flex: 1,
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xff8377D1), width: 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Aplicar Fecha',
                      style: TextStyle(
                          color: Color(0xff8377D1),
                          fontSize: 15,
                          fontStyle: FontStyle.italic),
                    ))),
          ],
        ),
      ),
    );
  }
}

class NotificationDIalog extends StatelessWidget {
  const NotificationDIalog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<TimeOfDay> _selectTime(BuildContext context) {
  final now = DateTime.now();
  return showTimePicker(
      context: context,
      helpText: 'Seleccione la hora:',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      builder: (context, _) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                // Using 12-Hour format
                alwaysUse24HourFormat: false),
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
}

Future<DateTime> _selectDateTime(BuildContext context) {
  return showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      helpText: 'Seleccione la fecha:',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
      lastDate: DateTime(2100),
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
}
