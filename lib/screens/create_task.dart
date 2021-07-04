import 'package:flutter/material.dart';
import 'package:todo/components/app_banner.dart';
import 'package:todo/components/forms/task_form.dart';
import 'package:todo/constants/default_theme.dart';
import 'package:todo/constants/text_styles.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBanner(
        toolbarWidth: MediaQuery.of(context).size.width * .90,
        toolbarHeight: MediaQuery.of(context).size.height * .25,
        header: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
          ),
          onPressed: () => Navigator.pop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back, color: Colors.white,),
              SizedBox(width: 10,),
              Text("Back".toUpperCase(), style: kAppTitleTextStyle.copyWith(color: Colors.white),)
            ],
          ),
        ),
        content: RichText(
          text: TextSpan(
              text: "Create your fresh \nnew task",
              style: kGreetingTextStyle.copyWith(color: textColor),

          ),

        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 25),
        child:  Flex(
          direction: Axis.vertical,
          children: [
            TaskForm(),
          ],
        ),
      )
    );
  }
}
