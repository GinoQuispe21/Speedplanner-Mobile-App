import 'STask.dart';

class Group {
  int id;
  String name;
  String description;
  List<STask> listSimpleTasks = [];
  Group(this.id, this.name, this.description, this.listSimpleTasks);
}
