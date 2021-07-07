
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService extends  GetxService {

  late SharedPreferences _sharedPreferences;
  @override
  Future<SettingService> onInit() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    this.syncDefaultLang();
    this.syncDefaultTheme();
    return this;
  }


  void syncDefaultLang() {
    String lang = this._sharedPreferences.getString("app_lang") ?? "system";
    this._sharedPreferences.setString("app_lang", lang);
  }

  void syncDefaultTheme() {
    String themeData =
        this._sharedPreferences.getString("theme") ?? ThemeMode.system.toString();
    this._sharedPreferences.setString("theme", themeData);
  }

  void updateLanguage(Locale locale) async {
    await this._sharedPreferences.setString("app_lang", locale.toString());
    Get.updateLocale(locale);
  }

  void updateTheme(ThemeMode themeMode) async {
    await this._sharedPreferences.setString("theme", themeMode.toString());
    Get.changeThemeMode(themeMode);
  }

  Locale? appLang() {
    String? appLang = this._sharedPreferences.getString("app_lang") ?? "system";
    return (appLang == "system") ? Get.deviceLocale : Locale(appLang);
  }

  ThemeMode theme() {
    String? theme =
        this._sharedPreferences.getString("theme") ?? ThemeMode.system.toString();

    return ThemeMode.values
        .firstWhere((element) => element.toString() == theme);
    return theme as ThemeMode;
  }

  String get languageCode {
    String? appLang = this._sharedPreferences.getString("app_lang") ?? "system";
    return (appLang == "system") ? "system" : Locale(appLang).languageCode;
  }


}
