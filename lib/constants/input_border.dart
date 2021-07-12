import 'package:flutter/material.dart';
import 'package:todo/constants/default_theme.dart';
kTodoAppInputBorder(BuildContext context, {label: String,  String? errorText, Widget? suffix, FocusNode? focusNode}) {
  return InputDecoration(
      contentPadding: EdgeInsets.all(10),
      labelText: label,
      errorText: errorText,
      labelStyle: (focusNode?.hasPrimaryFocus ?? false) ? TextStyle(
          color: accentColor,
      ) : Theme.of(context).inputDecorationTheme.labelStyle,
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
            color: accentColor,
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
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always
  );
}
