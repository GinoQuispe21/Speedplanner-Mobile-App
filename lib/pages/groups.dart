import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:speedplanner/models/Group.dart';
import 'package:speedplanner/Services/GroupService.dart';
import 'package:speedplanner/Services/GetAllCourses.dart';

class Groups extends StatefulWidget {
  final int id;
  final String token;

  const Groups({this.id, this.token, Key key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  String formatter = '';
  List<Group> groupList;
  GetAllCoursesByUserIdService coursesService =
      new GetAllCoursesByUserIdService();
  GroupService groupService = new GroupService();

  void getDate() {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  @override
  void initState() {
    super.initState();
    getDate();
    coursesService.getAllCoursesByUserId(widget.id, widget.token);
    groupService.getCourseName(widget.id, widget.token, 1);
    groupService.getGroup(widget.id, widget.token, 1, groupService.courseName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: FloatingActionButton(
          heroTag: "addGroupBtn",
          backgroundColor: Color(0x00000000),
          elevation: 0,
          onPressed: () {},
          child: const Icon(
            //
            Icons.add_circle,
            color: Color(0xff8377D1),
            size: 50,
          ),
        ),
      ),
      body: Container(
          height: size.height,
          width: double.infinity,
          decoration: BoxDecoration(color: Color(0xffE9EBF8)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height / 1.57,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: groupList.length,
                          itemBuilder: (context, index) {
                            return groupCard(groupList[index]);
                          }),
                    )
                  ],
                )),
                Positioned(
                  bottom: 0,
                  child: dateFooter(
                      context: context, currentDate: 'Date: ' + formatter),
                )
              ],
            ),
          )),
    );
  }
}

TextStyle detailTitles() {
  return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Colors.black);
}

TextStyle groupName() {
  return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Colors.white);
}

Widget groupCard(Group group) {
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Color(0xff8377D1)),
          child: Text(
            'Grupo Personal',
            textAlign: TextAlign.center,
            style: groupName(),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: backgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Descripción',
                      textAlign: TextAlign.start,
                      style: detailTitles(),
                    ),
                  ],
                ),
                Row(
                  children: [Text('Grupo para uso personal de Lino Montero')],
                ),
                Divider(
                  height: 20.0,
                  thickness: 1.5,
                  color: Color(0Xff707070),
                ),
                Row(children: [Text('Miembros', style: detailTitles())]),
                Row(
                  children: [
                    Text('Lino Montero',
                        style: TextStyle(fontStyle: FontStyle.italic))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Creador del grupo',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  ],
                ),
                Divider(
                  height: 20.0,
                  thickness: 1.5,
                  color: Color(0Xff707070),
                ),
                Row(
                  children: [
                    Text(
                      'Curso',
                      style: detailTitles(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Aplicaciones para Dispositivos Móviles',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
