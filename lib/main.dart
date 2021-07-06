import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo/todo_app.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(TodoApp());
}
