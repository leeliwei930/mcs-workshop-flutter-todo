import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:todo/components/forms/task_form.dart';

import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:todo/controllers/tasks_controller.dart';
import 'package:todo/exceptions/form_exception.dart';
import 'package:todo/exceptions/toast_exception.dart';
import 'package:todo/models/task.dart';
class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {

  late TasksController controller;
  FormError? formError  ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.controller = Get.find<TasksController>();
  }

  void submitForm(Task task) async  {
      try {
        await controller.createTask(task);

        Get.back(result: "task_created_success");

      } catch (error) {
        if(error is FormException){
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
              Obx(() => TaskForm(
                  isLoading: controller.createTaskLoading(),
                  submitButtonText: "Create Task",
                  onSubmit: submitForm,
                  formError: formError,
              ),)
            ],
          ),
        )
      ),
    );
  }
}


