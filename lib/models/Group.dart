import 'Member.dart';

class Group {
  int id;
  String name;
  String description;
  String courseName;
  List<Member> members;
  Group(this.id, this.name, this.description, this.courseName, this.members);
}
