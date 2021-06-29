import 'package:flutter/material.dart';
import 'package:todo/constants/default_theme.dart';
import 'package:todo/constants/text_styles.dart';

class TaskListItem extends StatefulWidget {

  final String title;
  final bool completed;
  final String? dueDate;



  const TaskListItem({Key? key , required this.title, required this.completed, this.dueDate}) : super(key: key);


  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 16),
      leading: Checkbox(
        value: widget.completed,
        shape: CircleBorder(),
        onChanged: (bool? value){
          setState(() {
            print(value);
          });
        },
      ),
      title: Text(widget.title, style: kTaskTitleTextStyle,),
      subtitle: Column(
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: taskDueDateTextColor, size: 12,),
                SizedBox(
                  width: 10,
                ),
                Text(widget.dueDate ?? "", style: kTaskDueDateTextStyle,)
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              decoration:  BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: .25)
                  )
              ),

            )
          ],
      ),
      isThreeLine: true,

    );
  }
}
