
import 'dart:convert';

import 'package:todo/models/task.dart';

void main(){
  List<Map<String, dynamic>> tasksResponse = List.of([
    {
      "id": 1,
      "completed": false,
      "title": "Learn Flutter",
      "description": null,
      "due_at": null,
      "created_at": "2021-07-04T08:35:49.384Z",
      "updated_at": "2021-07-04T08:35:49.392Z"
    }
  ]);
  List<Task> tasks = tasksResponse.map(( Map<String, dynamic> taskJSON) => Task.fromJson(taskJSON)).toList();
  print(tasks.first.title);
}

