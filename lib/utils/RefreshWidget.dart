import 'package:flutter/material.dart';

//!First try to add a refresh widget for some pages

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;

  const RefreshWidget({
    Key key,
    @required this.onRefresh,
    @required this.child,
  }) : super(key: key);

  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) => buildDataList();

  Widget buildDataList() => RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: widget.child,
      );
}
