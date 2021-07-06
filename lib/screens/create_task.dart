import 'package:flutter/material.dart';
import 'package:todo/components/forms/task_form.dart';

import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:todo/models/task.dart';
class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  bool isLoading = false;

  void submitForm(Task task) async  {
    setState(() {
      this.isLoading = true;
    });
      await Future.delayed(Duration(seconds: 3));
    print(task);
    setState(() {
      this.isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        title: "Create A New Task",
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
                isLoading: isLoading,
                submitButtonText: "Create Task",
                onSubmit: submitForm
              ),
            ],
          ),
        )
      ),
    );
  }
}


