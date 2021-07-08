import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/components/app_banner.dart';
import 'package:todo/components/brand/app_title.dart';
import 'package:todo/components/navigations/tab_item.dart';
import 'package:todo/components/navigations/tabs.dart';
import 'package:todo/components/task/task_list_item.dart';
import 'package:todo/constants/text_styles.dart';
import 'package:todo/controllers/tasks_controller.dart';
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
 List<Task> tasks = List.of([]);
  int selectedTaskStatus = 0;


  List<Task> get completedTasks => this.tasks.where((element) => element.completed == true).toList();
  List<Task> get uncompletedTasks => this.tasks.where((element) => element.completed == false).toList();

  List<Task> get currentShownTasks {
    switch(this.selectedTaskStatus){
      case 0:
        return this.tasks;
      case 1:
        return this.uncompletedTasks;
      case 2:
      default:
        return this.completedTasks;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.tasksController = Get.put(TasksController()..onInit());
    this.tasks = [
      Task(
          id: "1",
          title: "Learn NodeJS",
          completed: true,
          dueDate: DateTime.now().add(Duration(days: 1))),
      Task(
          id: "2",
          title: "Develop API",
          completed: false,
          dueDate: DateTime.now().add(Duration(days: 10))),
      Task(
          id: "3",
          title: "Learn Flutter",
          completed: false,
          dueDate: DateTime.now().add(Duration(days: 2))),
      Task(
          id: "4",
          title: "Test My Code",
          completed: false,
          dueDate: DateTime.now().add(Duration(days: 14))),
    ];
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
        content: RichText(
          text: TextSpan(
              text: "Hello.\n",
              style: kGreetingTextStyle.copyWith(color: Color(0xFF6366F1)),
              children: [
                TextSpan(
                  text: "You have ${uncompletedTasks.length} uncompleted task, and  ${completedTasks.length} completed tasks.",
                  style: kGreetingTextStyle.copyWith(color: Colors.black),

                )
              ]
          ),

        ),
        bottom: Tabs(
          onTabChanged: (int index){
            setState((){
                  this.selectedTaskStatus = index;
              });
          },
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
              Expanded(

                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index){
                      return  Divider(
                        indent: MediaQuery.of(context).size.width * .20,
                      );
                    },
                itemBuilder: buildTaskList , itemCount: currentShownTasks.length, ))
            ],
          )
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CreateTask()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  TaskListItem buildTaskList(BuildContext context, int index){
    Task task = this.currentShownTasks[index];
    return TaskListItem(
      key: Key(task.id),
      title: task.title ,
      completed: task.completed,
      dueDate: task.dueDate.toString(),
      onChanged: (bool newVal){
        setState((){
          task.completed = newVal;
        });
      },
      onDelete: (){
        deleteTask(task.id);
      },
      onUpdate: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          return EditTask(
            task: task,
          );
        }));
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
}
