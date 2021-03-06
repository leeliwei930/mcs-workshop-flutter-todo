import 'package:flutter/material.dart';

const primaryColor = Color(0xFF03DAC5);
const accentColor =  Color(0xFF6366F1);
const textColor = Colors.black;
const taskTitleColor = accentColor;

const taskDueDateTextColor = Color(0xFF9CA3AF);

const dangerColor = Colors.redAccent;
const warningColor = Colors.amber;
ThemeData lightTheme =  ThemeData(
  primaryColor: primaryColor,
  accentColor: accentColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: textColor,
    backgroundColor: primaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: accentColor,
    ),
  ),

);
