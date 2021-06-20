import 'package:speedplanner/models/Group.dart';
import 'package:speedplanner/models/GroupList.dart';

class CourseGroup {
  int id;
  String name;
  String description;
  String email;
  String color;
  List<GroupList> listGroups = [];
  CourseGroup(this.id, this.name, this.description, this.email, this.color,
      this.listGroups);
}
