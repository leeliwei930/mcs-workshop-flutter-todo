import 'package:flutter/material.dart';
import 'package:todo/components/app_banner.dart';
import 'package:todo/components/brand/app_title.dart';
import 'package:get/get.dart';
import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:todo/constants/text_styles.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  SubPageAppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        title: "Settings",
        onBack: (){
          Get.back();
        },
      ),

    );
  }
}
