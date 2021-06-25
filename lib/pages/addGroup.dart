import 'package:flutter/material.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:intl/intl.dart';

class AddGroup extends StatefulWidget {
  final int id;
  final String token;
  final String username;
  const AddGroup({this.id, this.token, this.username, Key key})
      : super(key: key);

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  String formatter = '';
  var groupNameTxt = TextEditingController();
  var groupDescriptionTxt = TextEditingController();
  var courseTxt = TextEditingController();
  var memberNameTxt = TextEditingController();
  var memberDescriptionTxt = TextEditingController();

  void getDate() {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  @override
  void initState() {
    super.initState();
    getDate();
  }

  Future<void> addMemberDialog() async {
    Size size = MediaQuery.of(context).size;
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Agregar miembro',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            titlePadding: EdgeInsets.all(20),
            content: Container(
                width: size.width * 0.90,
                height: size.height / 3.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Nombre',
                            textAlign: TextAlign.start,
                            style: alertSubtitles()),
                      ],
                    ),
                    TextField(
                      controller: memberNameTxt,
                      style: fields(),
                      decoration: fieldDecoration(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Descripción',
                          style: alertSubtitles(),
                        ),
                      ],
                    ),
                    TextField(
                      controller: memberDescriptionTxt,
                      style: fields(),
                      decoration: fieldDecoration(),
                    ),
                  ],
                )),
            contentPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: purpleColor,
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                      child: Text(
                        'Agregar',
                        style: alertBtnText(),
                      ),
                      style: alertBtnStyle(),
                      onPressed: () {
                        //TODO: agregar mem a lista
                      }),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancelar',
                      style: alertBtnText(),
                    ),
                    style: alertBtnStyle(),
                  )
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarSpeedplanner(widget.username),
      body: Container(
        height: size.height,
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xffE9EBF8)),
        child: Container(
            child: Stack(
          children: <Widget>[
            Positioned(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Crear Grupo',
                      style: title(),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: Text(
                        'Nombre',
                        style: subtitle(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: size.width * 0.85,
                      child: TextField(
                        controller: groupNameTxt,
                        style: fields(),
                        decoration: fieldDecoration(),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: Text(
                        'Descripción',
                        style: subtitle(),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: size.width * 0.85,
                      child: TextField(
                        controller: groupDescriptionTxt,
                        style: fields(),
                        decoration: fieldDecoration(),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: Text(
                        'Miembros',
                        style: subtitle(),
                      ),
                    )
                  ],
                ),
                Container(
                  height: size.height / 7,
                  width: size.width * 0.85,
                  //decoration: BoxDecoration(color: Colors.purple[100]),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: Text(
                        'Agregar miembro',
                        style: addMem(),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        addMemberDialog();
                      },
                      heroTag: "addMemberBtn",
                      backgroundColor: Color(0x00000000),
                      elevation: 0,
                      child: Icon(
                        Icons.add_circle,
                        color: purpleColor,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: Text(
                        'Curso',
                        style: subtitle(),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: size.width * 0.85,
                      child: TextField(
                        controller: courseTxt,
                        style: fields(),
                        decoration: fieldDecoration(),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: ElevatedButton(
                      child: Text('Crear Grupo', style: btnText()),
                      style: btnStyle(),
                      onPressed: () {
                        //TODO: Post
                      }),
                )
              ],
            )),
            Positioned(
                bottom: 0,
                child: dateFooter(
                    context: context, currentDate: 'Date: ' + formatter))
          ],
        )),
      ),
    );
  }
}

TextStyle title() {
  return TextStyle(
      fontSize: 28,
      color: purpleColor,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold);
}

TextStyle subtitle() {
  return TextStyle(
      fontSize: 18,
      color: purpleColor,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold);
}

TextStyle members() {
  return TextStyle(
    fontSize: 18,
    color: purpleColor,
    fontStyle: FontStyle.italic,
  );
}

TextStyle fields() {
  return TextStyle(
      fontSize: 18,
      color: textFieldColor,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold);
}

TextStyle addMem() {
  return TextStyle(
      fontSize: 19,
      color: purpleColor,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w900);
}

InputDecoration fieldDecoration() {
  return InputDecoration(
    filled: true,
    contentPadding: EdgeInsets.all(16.0),
    fillColor: Colors.white,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(style: BorderStyle.none, width: 0)),
  );
}

ButtonStyle btnStyle() {
  return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.fromLTRB(30, 15, 30, 15)),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: purpleColor))));
}

TextStyle btnText() {
  return TextStyle(
      fontSize: 18,
      color: purpleColor,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold);
}

ButtonStyle alertBtnStyle() {
  return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.fromLTRB(25, 10, 25, 10)),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      elevation: MaterialStateProperty.all(0),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: purpleColor))));
}

TextStyle alertBtnText() {
  return TextStyle(
      fontSize: 16, color: purpleColor, fontStyle: FontStyle.italic);
}

TextStyle alertSubtitles() {
  return TextStyle(
      fontSize: 19,
      color: Colors.white,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold);
}
