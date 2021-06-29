class Task {
  late String id;
  late String title;
  late DateTime? dueDate;
  late bool completed;

  Task({required this.id, required this.title, this.completed = false, this.dueDate });

}

