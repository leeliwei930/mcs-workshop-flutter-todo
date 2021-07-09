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
            toolbarHeight: MediaQuery.of(context).size.height * .35,
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
          margin: EdgeInsets.only(top: 25),
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
                  Obx(() => (!tasksController.taskListLoading()) ? Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index){
                          return  Divider(
                            indent: MediaQuery.of(context).size.width * .20,
                          );
                        },
                        itemBuilder: buildTaskList , itemCount: tasks().length, )
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
            String? result = await Get.to(() => CreateTask());
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
      onDelete: (){
        deleteTask(task.id);
      },
      onUpdate: () async {
        String? result = await Get.to(() => EditTask(
          task: task,
        ));

        if(result == "task_updated_success"){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result!.tr),)
          );
        }
      },

    );
  }

  void deleteTask(String id){
    int index = this.tasks.indexWhere((element) => element.id == id);
    if(index >= 0){
      setState((){
        this.tasks.removeAt(index);
      });
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
