import 'package:speedplanner/models/Time.dart';

class Course {
  int id;
  String name;
  String description;
  String email;
  String color;
  List<Time> listTimes = [];
  Course(this.id, this.name, this.description, this.email, this.color,
      this.listTimes);
}
