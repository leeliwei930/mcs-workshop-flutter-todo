import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/components/app_banner.dart';
import 'package:todo/components/brand/app_title.dart';
import 'package:todo/components/navigations/tab_item.dart';
import 'package:todo/components/navigations/tabs.dart';
import 'package:todo/components/task/task_list_item.dart';
import 'package:todo/constants/text_styles.dart';
import 'package:todo/controllers/tasks_controller.dart';
import 'package:todo/exceptions/toast_exception.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/create_task.dart';
import 'package:todo/screens/edit_task.dart';
import 'package:todo/screens/settings_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TasksController tasksController;
  RxInt activeTabIndex = 0.obs;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.tasksController = Get.put(TasksController()..onInit());
    // wait the widget build finish the works
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      this.tasksController.fetchAllTasks();
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.tasksController.dispose();
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        extendBodyBehindAppBar: false,
        appBar:    AppBanner(
            toolbarWidth: MediaQuery.of(context).size.width,
            toolbarHeight: MediaQuery.of(context).size.height * .40,
            header: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                AppTitle(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: ()=> Get.to( () => SettingsPage()), icon: Icon(Icons.settings, color: Colors.white,))
                  ],
                )
              ],
            ),
            content: Obx(
                  () => RichText(
                text: TextSpan(
                    text: "Hello.\n",
                    style: kGreetingTextStyle.copyWith(color: Color(0xFF6366F1)),
                    children: [
                      TextSpan(
                        text: "You have ${tasksController.uncompletedTasks.length} uncompleted task, and  ${tasksController.completedTasks.length} completed tasks.",
                        style: kGreetingTextStyle.copyWith(color: Colors.black),

                      )
                    ]
                ),

              ),
            ),
            bottom: Tabs(
              onTabChanged: onTabChanged,
              tabs: [
                TabItem(
                  title: "All",
                ),
                TabItem(
                  title: "Uncompleted",
                ),
                TabItem(
                  title: "Completed",
                )
              ],
            )
        ),
        body: Container(
          margin: EdgeInsets.only(top: 15),
          child: Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  )
              ),
              margin: EdgeInsets.all(0),
              elevation: 25,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Obx(() => (!tasksController.taskListLoading() ) ? Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await  tasksController.fetchAllTasks(showLoadingIndicator: false);
                        },
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index){
                            return  Divider(
                              indent: MediaQuery.of(context).size.width * .20,
                            );
                          },
                          itemBuilder: buildTaskList , itemCount: tasks().length, ),
                      )
                  ) : Center(
                    heightFactor: 2,
                    child: CircularProgressIndicator(),)
                  )
                ],
              )
          ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? result = await Get.to(
                    () => CreateTask(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 500)
            );
            if(result == "task_created_success"){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result!.tr),)
              );
            }

          },
          child: Icon(Icons.add),
        ),
      );


  }

  TaskListItem buildTaskList(BuildContext context, int index){
    Task task = this.tasks.elementAt(index);
    return TaskListItem(
      key: Key(task.id),
      title: task.title ,
      completed: task.completed,
      dueDate: task.dueDate?.toString() ?? null,
      onChanged: (bool newVal)   {
         bool initialValue = task.completed;
         task.completed = newVal;
         tasksController.updateTask(task.id, task).then((updatedTask){
           tasksController.tasks.refresh();

         }).catchError((error){
           task.completed = initialValue;
           tasksController.tasks.refresh();

         });
      },
      onDelete: () async {
        await deleteTask(task);
      },
      onUpdate: () async {
        String? result = await Get.to(
          () => EditTask( task: task, ),
          transition: Transition.rightToLeftWithFade,
          duration: Duration(milliseconds: 500)
        );

        if(result == "task_updated_success"){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result!.tr),)
          );
        }
      },

    );
  }

  Future<void> deleteTask(Task task) async {
    // prompt a dialog
    bool? delete = await showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("delete_task_alert".tr),
        content: Text("delete_task_message".trParams({
          "name" :  task.title
        }) ?? ""),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("yes".tr,
              style: Theme.of(context).textTheme.button!.copyWith(
                  color: Colors.redAccent
              ),
            ),

          ),
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("no".tr,
                style: Theme.of(context).textTheme.button!.copyWith(
                    color: Theme.of(context).accentColor
                ),)
          )
        ],
      );
    });
    // if user click on delete
    if(delete != null && delete){
      try {
        await tasksController.deleteTask(task.id);
        await tasksController.fetchAllTasks();
      } catch (error){
        toastException(error, context);
      }
    }

  }

  void onTabChanged(int index){
    this.activeTabIndex.value = index;

  }

  get tasks {
    switch(activeTabIndex()){
      case 0:
        return tasksController.tasks;
      case 1:
        return tasksController.uncompletedTasks;
      default:
        return tasksController.completedTasks;
    }
  }
}
