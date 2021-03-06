import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:todo/components/app_banner.dart';
import 'package:todo/components/brand/app_title.dart';
import 'package:get/get.dart';
import 'package:todo/components/forms/login_form.dart';
import 'package:todo/constants/text_styles.dart';
import 'package:todo/exceptions/toast_exception.dart';
import 'package:todo/models/user.dart';
import 'package:todo/screens/auth/register_page.dart';
import 'package:todo/services/auth_service.dart';

import '../home.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthService authService;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this.authService = Get.find<AuthService>();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBanner(
          toolbarWidth: MediaQuery.of(context).size.width,
          toolbarHeight: MediaQuery.of(context).size.height * .25,
          content: AppTitle(),
          bottom:Text("please_login".tr, style: kAppTitleTextStyle.copyWith(fontSize: 24),),

      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => LoginForm(
                  isLoading: authService.isLoading(),
                  formKey: formKey,
                  onSubmit: (data) async {
                    await this.onLogin(data);
                  },
                ),),
                TextButton(
                    onPressed: () async {
                      String? result = await Get.to(
                          () => RegisterPage(),
                          transition: Transition.rightToLeftWithFade,
                          duration: Duration(milliseconds: 500)
                      );
                      if(result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("register_success")));
                      }
                    },
                    child: Text("fresh_register".tr)
                )
              ],
            )
          ),
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
        onPressed: !authService.isLoading() ? this.submitForm : null,
        child: (authService.isLoading()) ? CircularProgressIndicator(
          strokeWidth: 3.5,
          color: Colors.black,
        ) :Icon(Icons.arrow_forward_outlined),
      ),)
    );
  }

  void submitForm(){
    if(this.formKey.currentState!.validate()){
      this.formKey.currentState!.save();
    }
  }

  Future<void> onLogin(loginFormData) async {
    try {
      User user =  await authService.loginUsingPassword(
          loginFormData['identifier'], loginFormData['password']);
      Get.off(() => Home(), transition: Transition.rightToLeftWithFade);

    }  catch (error){
      toastException(error, context);

    }
  }
}
