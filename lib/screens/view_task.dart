import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:todo/constants/text_styles.dart';
import 'package:todo/models/task.dart';

class ViewTask extends StatefulWidget {
  final Task task;
  const ViewTask({Key? key, required this.task}) : super(key: key);

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .20,
        title: "${widget.task.title}",
        onBack: (){
          Get.back();
        },
        bottom: Builder(
          builder: (BuildContext context){
            return Text(widget.task.state.tr.toUpperCase(), style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: widget.task.stateColor,
              fontWeight: FontWeight.w600
            ));
          },
        )
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Builder(builder: (BuildContext context){
              if(widget.task.description != null){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("description".tr.toUpperCase(), style: kSectionTitle),
                    SizedBox(height: 5,),
                    RichText(text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText2,
                        text:  widget.task.description!.length <= 0 ? "no_description".tr : widget.task.description
                    ),),
                  ],
                );
              }
              return Container();
            }),

            SizedBox(height: 15,),
            Builder(builder: (BuildContext context){
              if(widget.task.dueDate != null){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("due_at".tr.toUpperCase(), style: kSectionTitle),
                    SizedBox(height: 5,),
                    Text(widget.task.dueDate!.toLocal().toString(),
                        style: Theme.of(context).textTheme.bodyText1
                    ),
                  ],
                );
              }
              return Container();
            })


          ],
        ),
      ),
    );
  }
}
