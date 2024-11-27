class Task {
  String title;
  String time;
  bool isCompleted;

  Task({
    required this.title,
    required this.time,
    this.isCompleted = false,
  });
}
