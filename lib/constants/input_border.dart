import 'package:flutter/material.dart';
import 'package:todo/constants/default_theme.dart';
kTodoAppInputBorder({label: String}) {
  return InputDecoration(
      contentPadding: EdgeInsets.all(8),
      labelText: label,
      labelStyle: TextStyle(
          color: accentColor,
      ),


      focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(2.5))

      ),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: dangerColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(2.5))
      ),
    focusedErrorBorder:OutlineInputBorder(
        borderSide: BorderSide(
          color: dangerColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(2.5))
    ),
    enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: accentColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(2.5))
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always
  );
}
