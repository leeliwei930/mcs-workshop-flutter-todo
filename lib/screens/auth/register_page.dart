import 'package:flutter/material.dart';
import 'package:todo/components/forms/register_form.dart';
import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:get/get.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        title: "register_new_account".tr,
        onBack: (){
          Get.back();
        },
      ),
      body:  Container(
          child:  SingleChildScrollView(
            child: Flex(
              direction: Axis.vertical,
              children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: RegisterForm(),
                  )
              ],
            ),
          )
      ),
    );
  }
}
