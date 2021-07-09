import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/components/forms/task_form.dart';

import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:todo/controllers/tasks_controller.dart';
import 'package:todo/exceptions/task_form_exception.dart';
import 'package:todo/exceptions/toast_exception.dart';
import 'package:todo/models/task.dart';
class EditTask extends StatefulWidget {
  final Task task;
  const EditTask({Key? key, required this.task}) : super(key: key);
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {

  late TasksController controller;
  FormError? formError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.controller = Get.find<TasksController>();
  }
  void submitForm(Task task) async   {
    try {
      await controller.updateTask(task.id, task);
      Get.back(result: "task_updated_success");
    } catch (error) {
      if(error is TaskFormException){
        this.formError = error.formError;
      }
      toastException(error, context);
    }
  }
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
              Obx(() => TaskForm(
                submitButtonText: "Save",
                initialValue: widget.task,
                isLoading: controller.updateTaskLoading(),
                formError: formError,
                onSubmit: submitForm,
              ),)
            ],
          ),
        )
      ),
    );
  }
}


