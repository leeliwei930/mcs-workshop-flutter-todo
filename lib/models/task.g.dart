// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: Task._parseIDToString(json['id'] as int),
    title: json['title'] as String,
    completed: json['completed'] as bool,
    dueDate: json['due_at'] == null
        ? null
        : DateTime.parse(json['due_at'] as String),
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'due_at': instance.dueDate?.toIso8601String(),
      'completed': instance.completed,
    };
