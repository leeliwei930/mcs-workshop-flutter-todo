import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/constants/default_theme.dart';
import 'package:todo/constants/text_styles.dart';

class TaskListItem extends StatefulWidget {
  final Key key;
  final String title;
  final bool completed;
  final String? dueDate;
  final Function? onChanged;
  final Function? onDelete;
  final Function? onUpdate;
  final Function? onBrowse;



  const TaskListItem({required this.key , required this.title, required this.completed, this.dueDate, this.onChanged, this.onDelete, this.onUpdate, this.onBrowse}) : super(key: key);


  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void closeSlide(BuildContext context){
    if(Slidable.of(context) != null){
      setState(() {
        Slidable.of(context)!.close();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Slidable(

      actionExtentRatio: 1 / 5,
      closeOnScroll: true,
      actionPane: SlidableScrollActionPane(),

      secondaryActions: [
        IconSlideAction(

          color: warningColor,
          foregroundColor: textColor,
          icon: Icons.edit,
          onTap: (){
            if(widget.onUpdate != null){
              widget.onUpdate!();
            }
          },
        ),
        IconSlideAction(

            color: dangerColor,
            foregroundColor: Colors.white,
            icon: Icons.close,
            onTap: (){
              if(widget.onDelete != null){
                widget.onDelete!();
              }
            }
        )


      ],
      child: Builder(
        builder: (context){

          return ListTile(
            onTap: (){
              closeSlide(context);
              if(widget.onBrowse != null){
                widget.onBrowse!();
              }
            },
            leading: Checkbox(
              value: widget.completed,
              shape: CircleBorder(),
              onChanged: (bool? value){
                if(widget.onChanged != null){
                  setState(() {
                    widget.onChanged!(value);
                  });
                }
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

              ],
            ),

            dense: true,
            isThreeLine: true,

          );
        },
      )
    );
  }
}
