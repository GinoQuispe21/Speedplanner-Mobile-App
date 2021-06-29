import 'package:flutter/material.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/models/SaveMember.dart';
import 'package:speedplanner/utils/emptyFieldsDialog.dart';
import 'package:speedplanner/Services/AddGroupService.dart';

class AddGroup extends StatefulWidget {
  final int courseId;
  final String token;
  final String username;
  final String courseName;
  const AddGroup(
      {this.courseId, this.token, this.username, this.courseName, Key key})
      : super(key: key);

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  String formatter = '';
  var groupNameTxt = TextEditingController();
  var groupDescriptionTxt = TextEditingController();
  var memberNameTxt = TextEditingController();
  var memberDescriptionTxt = TextEditingController();
  List<SaveMember> members = [];
  ScrollController scroll = new ScrollController(initialScrollOffset: 0);
  AddGroupService addGroupService = new AddGroupService();

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

  bool memberFieldsEmpty() {
    return memberNameTxt.text.isEmpty || memberDescriptionTxt.text.isEmpty;
  }

  Future<void> createGroup() async {
    addGroupService.groupName = groupNameTxt.text;
    addGroupService.groupDescription = groupDescriptionTxt.text;
    addGroupService.createGroup(widget.token, widget.courseId, members);
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
                        if (!memberFieldsEmpty()) {
                          members.add(new SaveMember(
                              memberNameTxt.text, memberDescriptionTxt.text));
                          setState(() {
                            memberNameTxt.text = '';
                            memberDescriptionTxt.text = '';
                          });
                          Navigator.pop(context);
                        } else {
                          _showDialog();
                        }
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

  bool groupFieldsEmpty() {
    return groupNameTxt.text.isEmpty || groupDescriptionTxt.text.isEmpty;
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return emptyFieldsDialog(context: context);
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
                    child: members.isEmpty
                        ? Text(
                            'Aún no se han agregado miembros',
                            style: memberStyle(),
                          )
                        : RawScrollbar(
                            controller: scroll,
                            isAlwaysShown: true,
                            thumbColor: scrollColor,
                            radius: Radius.circular(8),
                            child: ListView.builder(
                                itemCount: members.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              '${members[index].name}',
                                              textAlign: TextAlign.left,
                                              style: memberStyle(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              '-${members[index].description}',
                                              textAlign: TextAlign.left,
                                              style: memberStyle(),
                                            ),
                                          )
                                        ],
                                      ));
                                }),
                          )),
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
                      child: Text(
                        '${widget.courseName}',
                        style: fields(),
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
                        if (!groupFieldsEmpty()) {
                          createGroup();
                          setState(() {
                            groupNameTxt.text = '';
                            groupDescriptionTxt.text = '';
                            members = [];
                          });
                        } else {
                          _showDialog();
                        }
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

TextStyle memberStyle() {
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
