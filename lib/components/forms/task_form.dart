import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                focusNode: FocusNode(
                  canRequestFocus: false
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,

                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
