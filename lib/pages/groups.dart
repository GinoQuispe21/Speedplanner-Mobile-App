import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:speedplanner/Services/UserService.dart';
import 'package:speedplanner/pages/addGroup.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:speedplanner/models/Group.dart';
import 'package:speedplanner/Services/GroupService.dart';
import 'package:speedplanner/Services/GetAllCourses.dart';
import 'package:speedplanner/Services/ProfileService.dart';
import 'package:speedplanner/models/Member.dart';
import 'package:speedplanner/models/Course.dart';

class Groups extends StatefulWidget {
  final int id;
  final String token;

  Groups({this.id, this.token, Key key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  bool loading = true;
  String formatter = '';
  List<Group> groupList = [];
  List<Course> courses = [];
  List<Member> memberList = [];
  GetAllCoursesByUserIdService coursesService =
      new GetAllCoursesByUserIdService();
  GroupService groupService = new GroupService();
  ProfileService profileService = new ProfileService();
  UserService userService = new UserService();
  String name = '';
  String username = '';
  ScrollController scrollController =
      new ScrollController(initialScrollOffset: 0);
  ScrollController mainScroll = new ScrollController(initialScrollOffset: 0);

  _dialogCourses(context) {
    return showDialog(
        context: context,
        builder: (ctxt) => new AlertDialog(
              title: Center(
                  child: Text(
                "Crear Curso",
                style: TextStyle(
                    color: purpleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )),
              backgroundColor: backgroundColor,
              content: Container(
                height: 63.0 * courses.length,
                width: 300,
                child: Column(
                  children: [
                    Text("Elija un curso para el grupo",
                        style:
                            TextStyle(color: Color(0xff9C9DA6), fontSize: 15)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 50.0 * courses.length,
                        width: 300,
                        child: ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddGroup(
                                              courseId: courses[index].id,
                                              token: widget.token,
                                              username: username,
                                              courseName: courses[index].name,
                                            )));
                              },
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Color(int.parse(courses[index].color)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      courses[index].name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void getDate() {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  @override
  void initState() {
    super.initState();
    getDate();
    getCourses();
    getName();
  }

  void getCourses() async {
    await coursesService.getAllCoursesByUserId(widget.id, widget.token);
    for (int i = 0; i < coursesService.courses.length; i++) {
      courses.add(coursesService.courses[i]);
      print("added " + courses[i].name);
    }
    await getGroups();
  }

  void getGroups() async {
    for (int i = 0; i < courses.length; i++) {
      await groupService.getAllGroups(widget.id, widget.token, courses[i].id);
    }
    setGroups();
  }

  void setGroups() {
    setState(() {
      groupList = groupService.groups;
      print("gl size:" + groupList.length.toString());
      print("groups size: " + groupService.groups.length.toString());
    });
    loading = false;
  }

  void getName() async {
    await profileService.getProfileData(widget.id, widget.token);
    await userService.getUserData(widget.id, widget.token);
    setState(() {
      name = profileService.name;
      username = userService.user;
      print('name: ' + name);
      print('username: ' + username);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        //Eliminar FAB al terminar con AddGroup
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: FloatingActionButton(
            heroTag: "addGroupBtn",
            backgroundColor: Color(0x00000000),
            elevation: 0,
            onPressed: () {
              _dialogCourses(context);
            },
            child: const Icon(
              //
              Icons.add_circle,
              color: Color(0xff8377D1),
              size: 50,
            ),
          ),
        ),
        body: loading
            ? loadingGroups()
            : groupList.isEmpty
                ? noGroups()
                : Container(
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
                                    controller: scrollController,
                                    itemCount: groupList.length,
                                    itemBuilder: (context, index) {
                                      return groupCard(groupList[index], name,
                                          scrollController, context);
                                    }),
                              )
                            ],
                          )),
                          Positioned(
                            bottom: 0,
                            child: dateFooter(
                                context: context,
                                currentDate: 'Date: ' + formatter),
                          )
                        ],
                      ),
                    )));
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

Widget loadingGroups() {
  return Container(
    decoration: BoxDecoration(color: Color(0xffE9EBF8)),
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Center(
              child: SpinKitFadingCircle(
            color: purpleColor,
            size: 50,
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'Cargando grupos',
            style: TextStyle(color: purpleColor),
          ),
        )
      ],
    )),
  );
}

Widget noGroups() {
  return Container(
    decoration: BoxDecoration(color: Color(0xffE9EBF8)),
    child: Center(
      child: Text(
        'Todavía no se han agregado Grupos. Cree un Curso para añadir sus Grupos',
        style: TextStyle(
            color: purpleColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic),
      ),
    ),
  );
}

Widget groupCard(Group group, String name, ScrollController scrollController,
    BuildContext context) {
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
                      'Curso',
                      style: detailTitles(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${group.courseName}',
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Text('-' + name + '\nCreador del grupo',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600))),
                          group.members.length > 0
                              ? Container(
                                  height: 75,
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: RawScrollbar(
                                    controller: scrollController,
                                    isAlwaysShown: true,
                                    thumbColor: purpleColor,
                                    radius: Radius.circular(8),
                                    child: ListView.builder(
                                        itemCount: group.members.length,
                                        itemBuilder: (BuildContext context,
                                            int memberIndex) {
                                          return Text(
                                            '-${group.members[memberIndex].name}\n' +
                                                '${group.members[memberIndex].description}',
                                            textAlign: TextAlign.justify,
                                          );
                                        }),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
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
