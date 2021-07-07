import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo/constants/todo_translation.dart';
import 'package:todo/screens/auth/login_page.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/services/auth_service.dart';
import 'package:todo/services/setting_service.dart';

import 'constants/default_theme.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late SettingService settingService;
  late AuthService authService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.settingService = Get.find<SettingService>();
    this.authService = Get.find<AuthService>();
  }
  @override
  Widget build(BuildContext context) {

    // force portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return GetMaterialApp(
      theme: lightTheme,
      themeMode: ThemeMode.system,
      title: "Todo.",
      fallbackLocale: Locale('en_GB'),
      locale: settingService.appLang(),
      translations: TodoTranslation(),
      debugShowCheckedModeBanner: false,
      home: (authService.isAuthenticated()) ? Home() : LoginPage()
    );
  }
}
