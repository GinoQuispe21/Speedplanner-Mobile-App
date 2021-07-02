import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:speedplanner/models/Course.dart';
import 'package:speedplanner/models/ListTask.dart';
import 'package:speedplanner/models/SimpleTask.dart';
import 'package:speedplanner/models/StudyGroup.dart';
import 'package:speedplanner/models/TimedTask.dart';
import 'package:speedplanner/pages/createSimpleTask.dart';
import 'package:speedplanner/services/DeleteUpdateCourse.dart';
import 'package:speedplanner/services/GetAllGroupsByCourseId.dart';
import 'package:speedplanner/services/GetSimpleTaskById.dart';
import 'package:speedplanner/services/UpdateDeleteTask.dart';
import 'package:speedplanner/utils/AppBar.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:speedplanner/utils/dateFooter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailCourse extends StatefulWidget {
  final Course course;
  final String token;
  final String username;
  final int userId;
  const DetailCourse({this.course, this.token, this.username, this.userId, key})
      : super(key: key);

  @override
  _DetailCourseState createState() => _DetailCourseState();
}

class _DetailCourseState extends State<DetailCourse> {
  String formatter = '';
  double titleSize = 20.0;
  List<StudyGroup> listGroup = [];
  List<SimpleTask> listSimpleTask = [];
  List<TimedTask> listTimedTask = [];
  List<ListTask> listAllTasks = [];
  DeleteCourse deleteCourse = new DeleteCourse();
  UpdateCourse updateCourse = new UpdateCourse();
  GroupsService groupsService = new GroupsService();
  DeleteTaskService deleteTaskService = new DeleteTaskService();
  SimpleTaskService simpleTaskService = new SimpleTaskService();
  TextEditingController courseNameEditController = TextEditingController();
  TextEditingController courseDescriptionEditController =
      TextEditingController();
  TextEditingController courseEmailEditController = TextEditingController();

  TextEditingController getTaskNameController = TextEditingController();
  TextEditingController getTaskDescriptionController = TextEditingController();
  TextEditingController getTaskDeadlineController = TextEditingController();
  TextEditingController getTaskFinishedController = TextEditingController();

  TextEditingController getTimedTaskNameController = TextEditingController();
  TextEditingController getTimedTaskDescriptionController =
      TextEditingController();
  TextEditingController getTimedTaskStartController = TextEditingController();
  TextEditingController getTimedTaskEndController = TextEditingController();
  TextEditingController getTimedTaskFinishedController =
      TextEditingController();

  GetSimpleTaskService getSimpleTaskService = new GetSimpleTaskService();
  //SimpleTaskUpdateModel simpleTaskUpdateModel;

  GetTimedTaskService getTimedTaskService = new GetTimedTaskService();
  //TimedTaskUpdateModel timedTaskUpdateModel;

  UpdateSimpleTaskService updateSimpleTaskService =
      new UpdateSimpleTaskService();

  UpdateTimedTaskService updateTimedTaskService = new UpdateTimedTaskService();

  void updateFinishedTask(studyGroupId, taskId, type, token) async {
    if (type == "(TS)") {
      await getSimpleTaskService.getSimpleTaskByStudyGroupId(
          studyGroupId, taskId, token);
      bool finishedChanged;
      String deadline;
      String title;
      String description;
      finishedChanged = !getSimpleTaskService.simpleTaskUpdateModel.finished;
      deadline = getSimpleTaskService.simpleTaskUpdateModel.deadline;
      title = getSimpleTaskService.simpleTaskUpdateModel.title;
      description = getSimpleTaskService.simpleTaskUpdateModel.description;
      updateSimpleTask(studyGroupId, taskId, token, finishedChanged.toString(),
          deadline, title, description);
    } else {
      if (type == "(TC)") {
        await getTimedTaskService.getTimedTaskByStudyGroupId(
            studyGroupId, taskId, token);
        bool finishedChanged;
        String inicio;
        String fin;
        String title;
        String description;
        finishedChanged = !getTimedTaskService.timedTaskUpdateModel.finished;
        inicio = getTimedTaskService.timedTaskUpdateModel.inicio;
        fin = getTimedTaskService.timedTaskUpdateModel.fin;
        title = getTimedTaskService.timedTaskUpdateModel.title;
        description = getTimedTaskService.timedTaskUpdateModel.description;
        updateTimedTask(studyGroupId, taskId, token, finishedChanged.toString(),
            inicio, fin, title, description);
      }
    }
  }

  void updateSimpleTask(studyGroupId, taskId, token, finished, deadline, title,
      description) async {
    updateSimpleTaskService.updateSimpleTaskByStudyGroupId(
        studyGroupId, taskId, token, finished, deadline, title, description);
    //await ;
  }

  void updateTimedTask(studyGroupId, taskId, token, finished, inicio, fin,
      title, description) async {
    updateTimedTaskService.updateTimedTaskByStudyGroupId(
        studyGroupId, taskId, token, finished, inicio, fin, title, description);
  }

  void deleteTask(studyGroupId, typeTask, taskId, token) async {
    await deleteTaskService.deleteTaskByStudyGroupId(
        studyGroupId, typeTask, taskId, token);
  }

  void getSimpleTask(studyGroupId, typeTask, taskId, token, context) async {
    if (typeTask == "(TS)") {
      await getSimpleTaskService.getSimpleTaskByStudyGroupId(
          studyGroupId, taskId, token);
      getTaskNameController.text =
          getSimpleTaskService.simpleTaskUpdateModel.title;
      getTaskDescriptionController.text =
          getSimpleTaskService.simpleTaskUpdateModel.description;
      getTaskDeadlineController.text =
          getSimpleTaskService.simpleTaskUpdateModel.deadline;
      getTaskFinishedController.text =
          getSimpleTaskService.simpleTaskUpdateModel.finished.toString();
      bool finishedSimpleTask;
      finishedSimpleTask = getSimpleTaskService.simpleTaskUpdateModel.finished;

      _openPopupSimpleEditTask(
          context, studyGroupId, taskId, token, finishedSimpleTask);
    } else {
      if (typeTask == "(TC)") {
        await getTimedTaskService.getTimedTaskByStudyGroupId(
            studyGroupId, taskId, token);
        getTimedTaskNameController.text =
            getTimedTaskService.timedTaskUpdateModel.title;
        getTimedTaskDescriptionController.text =
            getTimedTaskService.timedTaskUpdateModel.description;
        getTimedTaskStartController.text =
            getTimedTaskService.timedTaskUpdateModel.inicio;
        getTimedTaskEndController.text =
            getTimedTaskService.timedTaskUpdateModel.fin;
        bool finished;
        finished = getTimedTaskService.timedTaskUpdateModel.finished;
        _openPopupTimedEditTask(context, studyGroupId, taskId, token, finished);
      }
    }
  }

  _openPopupTimedEditTask(
      context, studyGroupId, taskId, token, finishedTimedTask) {
    Alert(
        style: AlertStyle(
          backgroundColor: backgroundColor,
          descStyle: TextStyle(color: greenColor, fontSize: 15),
          titleStyle: TextStyle(
              color: greenColor, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        context: context,
        title: "Editar Curso",
        content: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nombre", style: TextStyle(fontSize: 14)),
                Container(
                  height: 30,
                  child: TextField(
                    controller: getTimedTaskNameController,
                    decoration: InputDecoration(),
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    onChanged: (text) {},
                  ),
                ),
                SizedBox(height: 10),
                Text("Descripción", style: TextStyle(fontSize: 14)),
                Container(
                  height: 70,
                  child: TextField(
                    controller: getTimedTaskDescriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    decoration: InputDecoration(),
                    onChanged: (text) {},
                  ),
                ),
                SizedBox(height: 10),
                Text("Inicio", style: TextStyle(fontSize: 14)),
                Container(
                  height: 30,
                  child: TextField(
                    controller: getTimedTaskStartController,
                    decoration: InputDecoration(),
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    onChanged: (text) {},
                  ),
                ),
                SizedBox(height: 10),
                Text("Fin", style: TextStyle(fontSize: 14)),
                Container(
                  height: 30,
                  child: TextField(
                    controller: getTimedTaskEndController,
                    decoration: InputDecoration(),
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    onChanged: (text) {},
                  ),
                ),
              ],
            )),
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
              "Editar",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            onPressed: () {
              updateTimedTask(
                  studyGroupId,
                  taskId,
                  token,
                  finishedTimedTask.toString(),
                  getTimedTaskStartController.text,
                  getTimedTaskEndController.text,
                  getTimedTaskNameController.text,
                  getTimedTaskDescriptionController.text);
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: "Tarea actualizada",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color(0xff30B18B),
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            color: purpleColor,
          )
        ]).show();
  }

  _openPopupSimpleEditTask(
      context, studyGroupId, taskId, token, finishedSimpleTask) {
    Alert(
        style: AlertStyle(
          backgroundColor: backgroundColor,
          descStyle: TextStyle(color: greenColor, fontSize: 15),
          titleStyle: TextStyle(
              color: greenColor, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        context: context,
        title: "Editar Curso",
        content: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nombre", style: TextStyle(fontSize: 14)),
                Container(
                  height: 30,
                  child: TextField(
                    controller: getTaskNameController,
                    decoration: InputDecoration(),
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    onChanged: (text) {},
                  ),
                ),
                SizedBox(height: 10),
                Text("Descripción", style: TextStyle(fontSize: 14)),
                Container(
                  height: 70,
                  child: TextField(
                    controller: getTaskDescriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    decoration: InputDecoration(),
                    onChanged: (text) {},
                  ),
                ),
                SizedBox(height: 10),
                Text("Inicio", style: TextStyle(fontSize: 14)),
                Container(
                  height: 30,
                  child: TextField(
                    controller: getTaskDeadlineController,
                    decoration: InputDecoration(),
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    onChanged: (text) {},
                  ),
                ),
              ],
            )),
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
              "Editar",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            onPressed: () {
              updateSimpleTask(
                  studyGroupId,
                  taskId,
                  token,
                  finishedSimpleTask.toString(),
                  getTaskDeadlineController.text,
                  getTaskNameController.text,
                  getTaskDescriptionController.text);
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: "Tarea actualizada",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color(0xff30B18B),
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            color: purpleColor,
          )
        ]).show();
  }

  _openPopupDeleteTask(context, studyGroupId, typeTask, taskId) {
    Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: backgroundColor,
          descStyle: TextStyle(color: Color(0xff9C9DA6), fontSize: 15),
          titleStyle: TextStyle(
              color: Color(0xffF87575),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        title: "Eliminar Tarea",
        desc: "¿Estás seguro? Esta acción sera permanente!",
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
              "Eliminar",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            onPressed: () {
              deleteTask(studyGroupId, typeTask, taskId, widget.token);
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: "Tarea eliminada",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color(0xff30B18B),
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            color: Color(0xffF87575),
          )
        ]).show();
  }

  _openPopupDeleteCourse(context) {
    Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: backgroundColor,
          descStyle: TextStyle(color: Color(0xff9C9DA6), fontSize: 15),
          titleStyle: TextStyle(
              color: Color(0xffF87575),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        title: "Eliminar Curso",
        desc: "¿Estás seguro? Esta acción sera permanente!",
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
              "Eliminar",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            onPressed: () {
              deleteCourses();
              Navigator.pop(context);
            },
            color: Color(0xffF87575),
          )
        ]).show();
  }

  _openPopupEditCourse(context) {
    courseNameEditController.text = widget.course.name;
    courseDescriptionEditController.text = widget.course.description;
    courseEmailEditController.text = widget.course.email;
    Alert(
        context: context,
        style: AlertStyle(
          backgroundColor: backgroundColor,
          descStyle: TextStyle(color: Color(0xff9C9DA6), fontSize: 15),
          titleStyle: TextStyle(
              color: purpleColor, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        title: "Editar Curso",
        content: Container(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Nombre", style: TextStyle(fontSize: 14)),
              Container(
                height: 30,
                child: TextField(
                  controller: courseNameEditController,
                  decoration: InputDecoration(),
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  onChanged: (text) {},
                ),
              ),
              SizedBox(height: 10),
              Text("Descripción", style: TextStyle(fontSize: 14)),
              Container(
                height: 70,
                child: TextField(
                  controller: courseDescriptionEditController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(),
                  onChanged: (text) {},
                ),
              ),
              SizedBox(height: 10),
              Text("Email", style: TextStyle(fontSize: 14)),
              Container(
                height: 30,
                child: TextField(
                  controller: courseEmailEditController,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(),
                  onChanged: (text) {},
                ),
              ),
            ],
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
              updateCourses();
            },
            color: purpleColor,
          )
        ]).show();
  }

  void getCurrentDate() async {
    DateTime now = new DateTime.now();
    formatter = DateFormat('yMMMd').format(now);
    print(formatter);
  }

  void getGroups() async {
    await groupsService.getAllGroupsByCourseId(widget.course.id, widget.token);
    setState(() {
      listGroup = groupsService.studyGroupList;
      listSimpleTask = groupsService.simpleTaskList;
      listTimedTask = groupsService.timedTaskList;
      listAllTasks = groupsService.listAllTasks;
    });
    print("Lista de grupos");
    for (int i = 0; i < listGroup.length; i++) {
      print(
          '${listGroup[i].id} - ${listGroup[i].name} - ${listGroup[i].descrpiton}');
    }
  }

  void updateCourses() async {
    print(widget.userId);
    print(widget.course.id);
    print(widget.token);
    print(courseNameEditController.text);
    print(courseDescriptionEditController.text);
    print(courseEmailEditController.text);
    print(widget.course.color);
    await updateCourse.updateCourseByUserId(
        widget.userId,
        widget.course.id,
        widget.token,
        courseNameEditController.text,
        courseDescriptionEditController.text,
        courseEmailEditController.text,
        widget.course.color);
  }

  void loadData() async {
    getCurrentDate();
    getGroups();
    //getSimpleTasks();
    print(widget.course.name.length);
    if (widget.course.name.length > 30) {
      titleSize = 16;
    }
  }

  void deleteCourses() async {
    print(widget.userId);
    print(widget.course.id);
    print(widget.token);
    await deleteCourse.deleteCoursesByUserId(
        widget.userId, widget.course.id, widget.token);
    //Navigator.pop(context);
    print("CURSO ELIMINADO");
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int colorCard = int.parse(widget.course.color);

    Widget widgetDetailCourse() => listGroup.length == 0
        ? Container(
            decoration: BoxDecoration(color: backgroundColor),
            height: size.height,
            width: double.infinity,
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
                    'Cargando detalle del curso',
                    style: TextStyle(color: purpleColor),
                  ),
                )
              ],
            ))
        : Container(
            height: size.height,
            width: double.infinity,
            decoration: BoxDecoration(color: backgroundColor),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                    top: 20,
                    child: Container(
                      width: size.width,
                      height: size.height / 13,
                      decoration: BoxDecoration(color: Color(colorCard)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  child: Text(
                                    "${widget.course.name}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: titleSize,
                                    ),
                                  ),
                                ),
                              ),
                              flex: 8),
                          Expanded(
                              child: Container(
                                child: Center(
                                  child: IconButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(
                                        Icons.edit_sharp,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      _openPopupEditCourse(context);
                                      //setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              flex: 1),
                          Expanded(
                            child: Container(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _openPopupDeleteCourse(context);
                                },
                              ),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    )),
                Positioned(
                  bottom: 10,
                  child: Container(
                      height: size.height / 1.4,
                      width: size.width / 1.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Decripción",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            '${widget.course.description}',
                            style: TextStyle(),
                          ),
                          Divider(
                            height: 20.0,
                            thickness: 1.5,
                            color: Color(0Xff707070),
                          ),
                          Text(
                            "Correo del Docente",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            '${widget.course.email}',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Divider(
                            height: 20.0,
                            thickness: 1.5,
                            color: Color(0Xff707070),
                          ),
                          Text(
                            "Horario de clase",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Container(
                            height: 23.0 * (widget.course.listTimes.length),
                            width: 200,
                            child: ListView.builder(
                                itemCount: widget.course.listTimes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                      '- ${widget.course.listTimes[index].day} -> ${widget.course.listTimes[index].starterTime} - ${widget.course.listTimes[index].finishTime}');
                                }),
                          ),
                          Divider(
                            height: 20.0,
                            thickness: 1.5,
                            color: Color(0Xff707070),
                          ),
                          Text(
                            "Grupos",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Container(
                            height: listGroup.length * 22.0,
                            child: ListView.builder(
                              itemCount: listGroup.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text('- ${listGroup[index].name}');
                                //Text('- ${listGroup[index].name}');
                              },
                            ),
                          ),
                          Divider(
                            height: 20.0,
                            thickness: 1.5,
                            color: Color(0Xff707070),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Tareas",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('${listAllTasks.length} por realizar',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: listAllTasks.length == 0
                                ? Center(
                                    child: Text("No se han programado tareas"),
                                  )
                                : Container(
                                    height: listAllTasks.length * 30.0,
                                    child: ListView.builder(
                                        itemCount: listAllTasks.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: IconButton(
                                                    padding:
                                                        new EdgeInsets.all(0.0),
                                                    icon: Icon(listAllTasks[
                                                                index]
                                                            .finished
                                                        ? Icons.check_box
                                                        : Icons
                                                            .check_box_outline_blank),
                                                    //.check_box_outline_blank,
                                                    //Icons.check_box,
                                                    onPressed: () {
                                                      updateFinishedTask(
                                                          listAllTasks[index]
                                                              .studyGroupId,
                                                          listAllTasks[index]
                                                              .id,
                                                          listAllTasks[index]
                                                              .type,
                                                          widget.token);
                                                      setState(() {
                                                        listAllTasks[index]
                                                                .finished =
                                                            !listAllTasks[index]
                                                                .finished;
                                                        print(
                                                            listAllTasks[index]
                                                                .id);
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  child: Text(
                                                      "${listAllTasks[index].title} ${listAllTasks[index].type}",
                                                      style: listAllTasks[index]
                                                              .finished
                                                          ? TextStyle(
                                                              fontSize: 12,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic)
                                                          : TextStyle(
                                                              fontSize: 12)),
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: IconButton(
                                                      padding:
                                                          new EdgeInsets.all(
                                                              0.0),
                                                      icon: Icon(
                                                        Icons.edit_sharp,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {
                                                        getSimpleTask(
                                                            listAllTasks[index]
                                                                .studyGroupId,
                                                            listAllTasks[index]
                                                                .type,
                                                            listAllTasks[index]
                                                                .id,
                                                            widget.token,
                                                            context);
                                                      }),
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: IconButton(
                                                      padding:
                                                          new EdgeInsets.all(
                                                              0.0),
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {
                                                        _openPopupDeleteTask(
                                                          context,
                                                          listAllTasks[index]
                                                              .studyGroupId,
                                                          listAllTasks[index]
                                                              .type,
                                                          listAllTasks[index]
                                                              .id,
                                                        );
                                                      }),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                          )
                        ],
                      )),
                ),
                Positioned(
                    bottom: 0,
                    child: dateFooter(
                        context: context, currentDate: 'Date: ' + formatter))
              ],
            ),
          );

    return Scaffold(
      floatingActionButton: listGroup.length == 0
          ? null
          : Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text("Crear Tarea"),
                    ),
                    FloatingActionButton(
                      heroTag: "btn3",
                      backgroundColor: Color(0x00000000),
                      elevation: 0,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateSimpleTask(
                                      token: widget.token,
                                      username: widget.username,
                                      listGroup: listGroup,
                                      courseId: widget.course.id,
                                      courseName: widget.course.name,
                                    )));
                      },
                      child: const Icon(
                        Icons.add_circle_outline_sharp,
                        color: Color(0xff80C3B5),
                        size: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      appBar: appBarSpeedplanner(context, '${widget.username}'),
      body: widgetDetailCourse(),
    );
  }
}
