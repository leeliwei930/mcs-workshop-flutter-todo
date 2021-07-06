import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo/screens/home.dart';

import 'constants/default_theme.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return GetMaterialApp(
      theme: lightTheme,
      themeMode: ThemeMode.system,
      title: "Todo.",
      debugShowCheckedModeBanner: false,

      home: Home()
    );
  }
}
