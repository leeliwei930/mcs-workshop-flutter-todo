import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';
@JsonSerializable()
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
}
