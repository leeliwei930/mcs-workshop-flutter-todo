
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService extends  GetxService {

  late SharedPreferences _sharedPreferences;
  @override
  Future<SettingService> onInit() async {
    this._sharedPreferences = await SharedPreferences.getInstance();
    // auto sync the default lang to shared preferences
    this.syncDefaultLang();
    this.syncDefaultTheme();
    return this;
  }


  void syncDefaultLang() {
    // if there is no "app_lang" key in sharedPreferences, auto set a value of "app_lang" to system
    String lang = this._sharedPreferences.getString("app_lang") ?? "system";
    this._sharedPreferences.setString("app_lang", lang);
  }

  void syncDefaultTheme() {
    // if there is no "theme" key in sharedPreferences, auto set a value of "theme" to system

    String themeData =
        this._sharedPreferences.getString("theme") ?? ThemeMode.system.toString();
    this._sharedPreferences.setString("theme", themeData);
  }

  void updateLanguage(Locale locale) async {
    // update the shared_preferences app_lang value
    await this._sharedPreferences.setString("app_lang", locale.toString());
    // tell GetX update the locale for application state
    Get.updateLocale(locale);
  }

  void updateTheme(ThemeMode themeMode) async {
    // update the shared_preferences theme value
    await this._sharedPreferences.setString("theme", themeMode.toString());
    // tell GetX update the themes for application state
    Get.changeThemeMode(themeMode);
  }

  // language getter
  Locale? appLang() {
    // get the applang from sharedPreference, if null fallback to system
    String? appLang = this._sharedPreferences.getString("app_lang") ?? "system";
    return (appLang == "system") ? Get.deviceLocale : Locale(appLang);
  }

  ThemeMode theme() {
    // get the theme from sharedPreference, if null fallback to system theme mode
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
