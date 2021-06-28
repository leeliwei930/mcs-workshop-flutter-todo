import 'package:flutter/material.dart';

const _primaryColor = Color(0xFF03DAC5);
const _accentColor =  Color(0xFF6366F1);
const _textColor = Colors.black;

ThemeData lightTheme =  ThemeData(
  primaryColor: _primaryColor,
    accentColor: _accentColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: _textColor,
    backgroundColor: _primaryColor,
  )
);