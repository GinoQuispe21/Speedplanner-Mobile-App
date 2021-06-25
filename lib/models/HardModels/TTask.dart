class TimedTask {
  int id;
  bool finished;
  String startTime;
  String finishTime;
  String title;
  String description;
  TimedTask(this.id, this.finished, this.startTime, this.finishTime, this.title,
      this.description);
}

class TestTimedTask {
  int id;
  bool finished;
  String startTime;
  String finishTime;
  String title;
  String description;
  TestTimedTask(
      {this.id,
      this.finished,
      this.startTime,
      this.finishTime,
      this.title,
      this.description});
}
