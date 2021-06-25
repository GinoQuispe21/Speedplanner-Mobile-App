class SimpleTask {
  int id;
  bool finished;
  String deadline;
  String title;
  String description;
  SimpleTask(
      this.id, this.finished, this.deadline, this.title, this.description);
}

class TestSimpleTask {
  int id;
  bool finished;
  String deadline;
  String title;
  String description;
  TestSimpleTask(
      {this.id, this.finished, this.deadline, this.title, this.description});
}
