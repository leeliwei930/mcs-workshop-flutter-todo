import 'package:flutter/material.dart';
import 'package:todo/components/forms/task_form.dart';

import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:todo/models/task.dart';
class EditTask extends StatefulWidget {
  final Task task;
  const EditTask({Key? key, required this.task}) : super(key: key);
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        title: "Edit Task",
        onBack: (){
          Navigator.of(context).pop();
        },
      ),
      body: Container(
         child:  SingleChildScrollView(
          child: Flex(

            direction: Axis.vertical,
            children: [
              TaskForm(
                submitButtonText: "Save",
                initialValue: widget.task,
              ),
            ],
          ),
        )
      ),
    );
  }
}


