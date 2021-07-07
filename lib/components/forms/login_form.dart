import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:get/get.dart';
class LoginForm extends StatefulWidget {

  final GlobalKey<FormState> formKey;
  final Function? onSubmit;
  const LoginForm({Key? key, required this.formKey, this.onSubmit}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late GlobalKey _formKey;
  Map<String, String> loginFormData = {
    "identifier" : "",
    "password" : ""
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._formKey = widget.formKey;

  }
  @override
  Widget build(BuildContext context) {
    return Form(

      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            onSaved: (val){
              this.loginFormData['identifier'] = val ?? "";
            },
            validator: RequiredValidator(
              errorText: "username_required".tr
            ),
            decoration: InputDecoration(
              labelText: "identifier".tr
            ),
          ),
          TextFormField(
            onSaved: (val){
              this.loginFormData['password'] = val ?? "";
              this.emitOnSubmit();
            },
            obscureText: true,
            validator: RequiredValidator(
                errorText: "password_required".tr
            ),
            decoration: InputDecoration(
              labelText: "password".tr
            ),
          )
        ],
      ),
    );
  }

  void emitOnSubmit(){
    if(this.widget.onSubmit != null){
      this.widget.onSubmit!(this.loginFormData);
    }
  }
}
