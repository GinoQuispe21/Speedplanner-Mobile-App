import 'package:flutter/material.dart';

class TermsOfSerivceWidget extends StatefulWidget {
  const TermsOfSerivceWidget({Key key}) : super(key: key);

  @override
  _TermsOfSerivceWidgetState createState() => _TermsOfSerivceWidgetState();
}

class _TermsOfSerivceWidgetState extends State<TermsOfSerivceWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terminos de Servicios"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text("Terminos de Servicios"),
      ),
    );
  }
}
