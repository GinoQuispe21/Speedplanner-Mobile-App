import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:speedplanner/models/Group.dart';
import 'package:speedplanner/Services/GroupService.dart';
import 'package:speedplanner/Services/GetAllCourses.dart';
import 'package:speedplanner/Services/ProfileService.dart';

class Groups extends StatefulWidget {
  final int id;
  final String token;

  const Groups({this.id, this.token, Key key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  String formatter = '';
  List<Group> groupList = [];
  List<String> courseNames = [];
  GetAllCoursesByUserIdService coursesService =
      new GetAllCoursesByUserIdService();
  GroupService groupService = new GroupService();
  ProfileService profileService = new ProfileService();
  String name = '';

  void getDate() {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  @override
  void initState() {
    super.initState();
    getDate();
    getCourseNames();
    getGroups();
    getName();
  }

  void getCourseNames() async {
    await coursesService.getAllCoursesByUserId(widget.id, widget.token);
    setState(() {
      for (int i = 0; i < coursesService.courses.length; i++) {
        courseNames.add(coursesService.courses[i].name);
        print("added " + courseNames[i]);
      }
    });
  }

  void getGroups() async {
    await groupService.getAllGroups(widget.id, widget.token, 1);
    setState(() {
      groupList = groupService.groups;
      for (int i = 0; i < groupList.length; i++) {
        //groupList[i].courseName = courseNames[0];
      }
      print("gl size:" + groupList.length.toString());
      print("group size: " + groupService.groups.length.toString());
    });
  }

  void getName() async {
    await profileService.getProfileData(widget.id, widget.token);
    setState(() {
      name = profileService.name;
    });
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
                            return groupCard(
                                groupList[index], name, courseNames[index]);
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

Widget groupCard(Group group, String name, String courseName) {
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Color(0xff8377D1)),
          child: Text(
            '${group.name}',
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
                  children: [Text('${group.description}')],
                ),
                Divider(
                  height: 20.0,
                  thickness: 1.5,
                  color: Color(0Xff707070),
                ),
                Row(children: [Text('Miembros', style: detailTitles())]),
                Row(
                  children: [
                    Text(name, style: TextStyle(fontStyle: FontStyle.italic))
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
                      courseName,
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
