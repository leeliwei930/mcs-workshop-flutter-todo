import 'package:flutter/material.dart';
import 'package:todo/components/forms/register_form.dart';
import 'package:todo/components/navigations/subpage_app_bar.dart';
import 'package:get/get.dart';
import 'package:todo/exceptions/form_exception.dart';
import 'package:todo/exceptions/toast_exception.dart';
import 'package:todo/models/register_form_data.dart';
import 'package:todo/services/auth_service.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late AuthService _authService;

  FormError? formError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._authService = Get.find<AuthService>();
  }
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
                    child: Obx(() =>  RegisterForm(
                      formError: formError,
                      isLoading: _authService.isRegisterLoading(),
                      formKey: registerFormKey,
                      onSubmit: submitRegistrationForm
                    ),)
                  )
              ],
            ),
          )
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
      onPressed: !_authService.isRegisterLoading() ? this.submitForm : null,
      child: (_authService.isRegisterLoading()) ? CircularProgressIndicator(
        strokeWidth: 3.5,
        color: Colors.black,
      ) :Icon(Icons.done),
    ),),
    );
  }

  void submitForm(){
    if(this.registerFormKey.currentState!.validate()){
      this.registerFormKey.currentState!.save();
    }
  }

  void submitRegistrationForm(RegisterFormData data) async {
    try {
      await _authService.registerUsingEmail(data);
      Get.back(result: "register_success");
    } catch (error){
      if(error is FormException){
        this.formError = error.formError;
      }
      toastException(error, context);
    }
  }
}
