import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:speedplanner/utils/colors.dart';

openPopPupSettings(context) {
  Alert(title: "Configuración", context: context).show();
}

openLogOut(context) {
  Alert(
      style: AlertStyle(
        backgroundColor: backgroundColor,
        descStyle: TextStyle(color: Color(0xff9C9DA6), fontSize: 15),
        titleStyle: TextStyle(
            color: greenColor, fontWeight: FontWeight.bold, fontSize: 25),
      ),
      title: "¿Estás seguro?",
      desc:
          "Al cerrar sesión  estara obligado a iniciar sesión para poder ingresar nuevamente a Speedplanner",
      context: context,
      buttons: [
        DialogButton(
            child: Text(
              "Canecelar",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.grey[400]),
        DialogButton(
          child: Text(
            "Salir",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/signin',
              (Route<dynamic> route) => false,
            );
          },
          color: greenColor,
        )
      ]).show();
}

onSelected(context, item) {
  switch (item) {
    case 1:
      openPopPupSettings(context);
      break;
    case 2:
      openLogOut(context);
      break;
  }
}

Widget appBarSpeedplanner(context, name) {
  return AppBar(
    title: Text('Speedplanner'),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xff30B18B), Color(0xff8377d1)],
      )),
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20, 10.0, 0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              print("Nueva notificacion");
            },
            child: Icon(
              Icons.notifications,
              size: 26.0,
              color: Colors.white,
            ),
          )),
      PopupMenuButton<int>(
        onSelected: (item) => onSelected(context, item),
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            value: 1,
            child: Text("Configruación"),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Text("Cerrar Sesión"),
          )
        ],
      ),
      /*Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: GestureDetector(
          onTap: () {
            print("settings");
          },
          child: Icon(
            Icons.more_vert,
            size: 26.0,
            color: Colors.white,
          ),
        ),
      )*/
    ],
  );
}
