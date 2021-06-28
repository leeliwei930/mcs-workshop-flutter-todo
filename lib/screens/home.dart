import 'package:flutter/material.dart';
import 'package:todo/components/app_banner.dart';
import 'package:todo/components/brand/app_title.dart';
import 'package:todo/components/navigations/tab_item.dart';
import 'package:todo/components/navigations/tabs.dart';
import 'package:todo/constants/text_styles.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar:    AppBanner(
        toolbarWidth: MediaQuery.of(context).size.width * .90,
        toolbarHeight: MediaQuery.of(context).size.height * .40,
        header: AppTitle(),
        content: RichText(
          text: TextSpan(
              text: "Hello.\n",
              style: kGreetingTextStyle.copyWith(color: Color(0xFF6366F1)),
              children: [
                TextSpan(
                  text: "You have 0 uncompleted task, and 5 completed tasks.",
                  style: kGreetingTextStyle.copyWith(color: Colors.black),

                )
              ]
          ),

        ),
        bottom: Tabs(
          onTabChanged: (int index){
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.add),
      ),
    );
  }
}
