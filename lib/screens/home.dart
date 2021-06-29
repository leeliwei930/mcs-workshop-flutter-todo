import 'package:flutter/material.dart';
import 'package:todo/components/app_banner.dart';
import 'package:todo/components/brand/app_title.dart';
import 'package:todo/components/navigations/tab_item.dart';
import 'package:todo/components/navigations/tabs.dart';
import 'package:todo/components/task/task_list_item.dart';
import 'package:todo/constants/text_styles.dart';
import 'package:todo/models/task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
    this.tasks = [
      Task(title: "Learn NodeJS",
          completed: true,
          dueDate: DateTime.now().add(Duration(days: 1))),
      Task(title: "Develop API",
          completed: false,
          dueDate: DateTime.now().add(Duration(days: 10))),
      Task(title: "Learn Flutter",
          completed: false,
          dueDate: DateTime.now().add(Duration(days: 2))),
      Task(title: "Test My Code",
          completed: false,
          dueDate: DateTime.now().add(Duration(days: 14))),
    ];
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar:    AppBanner(
        toolbarWidth: MediaQuery.of(context).size.width * .90,
        toolbarHeight: MediaQuery.of(context).size.height * .35,
        header: AppTitle(),
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

                  child: ListView.builder(

                itemBuilder: buildTaskList , itemCount: currentShownTasks.length, ))
            ],
          )
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.add),
      ),
    );
  }

  TaskListItem buildTaskList(BuildContext context, int index){
    Task task = this.currentShownTasks[index];
    return TaskListItem(title: task.title , completed: task.completed, dueDate: task.dueDate.toString(), );
  }

}
