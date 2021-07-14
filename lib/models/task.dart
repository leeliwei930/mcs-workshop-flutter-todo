import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo/constants/default_theme.dart';

part 'task.g.dart';
@JsonSerializable(
  ignoreUnannotated: true
)
class Task {

  @JsonKey(name: "id", fromJson: _parseIDToString)
  late String id;

  @JsonKey(name: "title")
  late String title;

  late FocusNode titleFocusNode;

  @JsonKey(name: "description")
  late String? description;

  late FocusNode descriptionFocusNode;

  @JsonKey(name: "due_at")
  late DateTime? dueDate;

  late FocusNode dueDateFocusNode;

  @JsonKey(name: "completed")
  late bool completed;

  Task({required this.id, required this.title, this.completed = false, this.dueDate, this.description }){
    this.titleFocusNode = FocusNode();
    this.descriptionFocusNode = FocusNode();
    this.dueDateFocusNode = FocusNode();
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  static _parseIDToString(int val){
    return val.toString();
  }

  String toString(){
    return this.toJson().toString();
  }

  bool get isDue {
    return dueDate?.isAfter(DateTime.now()) ?? false;
  }

  Color get stateColor {
    if(isDue && !completed){
      return dangerColor;
    } else if(!completed) {
      return warningColor;
    } else {
      return primaryColor;
    }
  }


  String get state {
    if(isDue && !completed){
      return "task_due";
    } else if(!completed) {
      return "task_incomplete";
    } else {
      return "task_complete";
    }
  }
}
