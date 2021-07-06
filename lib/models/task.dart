import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';
@JsonSerializable()
class Task {

  @JsonKey(name: "id", fromJson: _parseIDToString)
  late String id;

  @JsonKey(name: "title")
  late String title;

  @JsonKey(name: "description")
  late String? description;

  @JsonKey(name: "due_at")
  late DateTime? dueDate;

  @JsonKey(name: "completed")
  late bool completed;

  Task({required this.id, required this.title, this.completed = false, this.dueDate, this.description });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  static _parseIDToString(int val){
    return val.toString();
  }

  String toString(){
    return this.toJson().toString();
  }
}
