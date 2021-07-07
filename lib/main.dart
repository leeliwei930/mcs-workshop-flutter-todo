import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:todo/services/auth_service.dart';
import 'package:todo/services/setting_service.dart';
import 'package:todo/todo_app.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized(); // before init shared preferences instance

  await Get.putAsync(() => SettingService().onInit());
  await Get.putAsync(() => AuthService().onInit());


  runApp(TodoApp());
}
