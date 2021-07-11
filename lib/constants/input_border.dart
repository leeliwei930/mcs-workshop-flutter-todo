import 'package:flutter/material.dart';
import 'package:todo/constants/default_theme.dart';
kTodoAppInputBorder({label: String,  String? errorText, Widget? suffix,}) {
  return InputDecoration(
      contentPadding: EdgeInsets.all(10),
      labelText: label,
      errorText: errorText,
      labelStyle: TextStyle(
          color: accentColor,
      ),
      suffixIconConstraints: BoxConstraints(
          minHeight: 15,
          minWidth: 15
      ),
      suffixIcon: Padding(
          padding: EdgeInsets.all(5),
          child: suffix
      ),
      focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(2.5)),

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
