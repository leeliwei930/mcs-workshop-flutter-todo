import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:todo/constants/input_border.dart';
import 'package:todo/exceptions/form_exception.dart';
import 'package:todo/models/register_form_data.dart';
import 'package:get/get.dart';
class RegisterForm extends StatefulWidget {
  final RegisterFormData? initialValue;
  final bool isLoading;
  final Function? onSubmit;
  final String submitText;
  final GlobalKey<FormState>? formKey;
  final FormError? formError;
  RegisterForm({
    Key? key, this.initialValue, this.isLoading = false, this.onSubmit, this.submitText = "create_account", this.formKey, this.formError}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late RegisterFormData formData;

  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.formKey != null){
      this._formKey = widget.formKey!;
    } else {
      this._formKey =  GlobalKey<FormState>();
    }
    this.formData = widget.initialValue ?? RegisterFormData();

    formData.fullnameFocusNode.addListener(() { setState(() {});});
    formData.usernameFocusNode.addListener(() { setState(() {});});
    formData.emailFocusNode.addListener(() { setState(() {});});
    formData.passwordFocusNode.addListener(() { setState(() {});});
    formData.confirmPasswordFocusNode.addListener(() { setState(() {});});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: !widget.isLoading,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            autocorrect: false,
            initialValue: formData.fullname,
            focusNode: formData.fullnameFocusNode,
            validator: MultiValidator([
              RequiredValidator(errorText: "field_required".trParams({
                "name" : "fullname".tr
              }) ?? ""),
              LengthRangeValidator(min: 3, max: 255, errorText: "field_range".trParams({
                "name" : "fullname".tr,
                "min" : "3",
                "max" : "255"
              }) ?? "")
            ]),
            onSaved: (val){
              this.formData.fullname = val ?? "";
            },
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(formData.usernameFocusNode);
            },
            decoration: kTodoAppInputBorder(
                context,
                label: "fullname".tr,
                focusNode: formData.fullnameFocusNode,
                errorText: widget.formError?.first("fullname")
            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: !widget.isLoading,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            initialValue: formData.username,
            focusNode: formData.usernameFocusNode,
            validator: MultiValidator([
              RequiredValidator(errorText: "field_required".trParams({
                "name" : "username".tr
              }) ?? ""),
              LengthRangeValidator(min: 3, max: 255, errorText: "field_range".trParams({
                "name" : "username".tr,
                "min" : "3",
                "max" : "255"
              }) ?? "")
            ]),
            onSaved: (val){
              this.formData.username = val ?? "";
            },
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(formData.emailFocusNode);
            },
            decoration: kTodoAppInputBorder(
                context,
                label: "username".tr,
                focusNode: formData.usernameFocusNode,
                errorText: widget.formError?.first("username")
            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: !widget.isLoading,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            initialValue: formData.email,
            focusNode: formData.emailFocusNode,
            validator: MultiValidator([
              EmailValidator(errorText: "field_email_invalid".tr),
              RequiredValidator(errorText: "field_required".trParams({
                "name" : "email".tr
              }) ?? ""),

            ]),
            onSaved: (val){
              this.formData.email = val ?? "";
            },
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(formData.passwordFocusNode);
            },
            decoration: kTodoAppInputBorder(
                context,
                label: "email".tr,
                focusNode: formData.emailFocusNode,
                errorText: widget.formError?.first("email")

            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: !widget.isLoading,
            obscureText: true,

            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            autocorrect: false,
            initialValue: formData.password,
            focusNode: formData.passwordFocusNode,
            validator: MultiValidator([
              RequiredValidator(errorText: "field_required".trParams({
                "name" : "password".tr
              }) ?? ""),
              LengthRangeValidator(min: 8, max: 30, errorText: "field_range".trParams({
                "name" : "password".tr,
                "min" : "8",
                "max" : "30"
              }) ?? "")
            ]),
            onSaved: (val){
              this.formData.password = val ?? "";
            },
            onChanged: (val){
              this.formData.password = val;
            },
            onFieldSubmitted: (val){
              FocusScope.of(context).requestFocus(formData.confirmPasswordFocusNode);
            },
            decoration: kTodoAppInputBorder(
                context,
                label: "password".tr,
                focusNode: formData.passwordFocusNode,
                errorText: widget.formError?.first("password")

            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: !widget.isLoading,
            obscureText: true,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            autocorrect: false,
            initialValue: formData.confirmPassword,
            focusNode: formData.confirmPasswordFocusNode,
            validator: (confirmPassword) => MatchValidator(
                errorText: "field_not_match".trParams({
                  "base" : "password".tr,
                  "target" : "confirmPassword".tr
                })??"")
                .validateMatch(formData.password, confirmPassword ?? ""),
            onSaved: (val){
              this.formData.confirmPassword = val ?? "";
              this.submitForm();
            },
            decoration: kTodoAppInputBorder(
                context,
                label: "confirmPassword".tr,
                focusNode: formData.confirmPasswordFocusNode,

            ),
          ),
        ],
      ),
    );
  }

  void submitForm() {
      if(this.widget.onSubmit != null){
        this.widget.onSubmit!(this.formData);
      }
  }
}
