import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:todo/components/countdown_button.dart';
import 'package:get/get.dart';
import 'package:todo/constants/input_border.dart';
import 'package:todo/exceptions/form_exception.dart';
import 'package:todo/models/password_form_data.dart';
class PasswordForm extends StatefulWidget {
  final String submitButtonText;
  final bool isLoading;
  final FormError? formError;
  final Function? onSubmit;
  const PasswordForm({Key? key, required this.submitButtonText, this.isLoading = false, this.formError, this.onSubmit}) : super(key: key);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState> ();
  bool hasFieldsError = false;
  PasswordFormData formData = PasswordFormData();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // listen to focus nodes on change event, and repaint the view when focus node state updated.
    formData.passwordFocusNode.addListener(() { setState(() {});});
    formData.newPasswordFocusNode.addListener(() { setState(() {});});
    formData.confirmPasswordFocusNode.addListener(() { setState(() {});});
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                textInputAction: TextInputAction.next,
                focusNode: formData.passwordFocusNode,
                obscureText: true,
                onSaved: (value){
                  formData.password = value?? "";
                },
                enabled: !widget.isLoading,
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: MultiValidator([
                  RequiredValidator(errorText: "field_required".trParams({
                    "name" : "current_password".tr
                  }) ?? ""),
                ]),
                decoration: kTodoAppInputBorder(
                    context,
                    label: "current_password".tr,
                    errorText:  widget.formError?.first("password")?.tr,
                    focusNode: formData.passwordFocusNode
                ),
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(formData.newPasswordFocusNode);
                },
            ),
            SizedBox(height: 10,),
            TextFormField(
              textInputAction: TextInputAction.next,
              focusNode: formData.newPasswordFocusNode,
              enabled: !widget.isLoading,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                formData.newPassword = val ?? "";
              },
              onChanged: (val){
                formData.newPassword = val;
              },
              decoration: kTodoAppInputBorder(
                context,
                label: "new_password".tr,
                errorText: widget.formError?.first("newPassword")?.tr,
                focusNode: formData.newPasswordFocusNode
              ),
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(formData.confirmPasswordFocusNode);
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              textInputAction: TextInputAction.done,
              focusNode: formData.confirmPasswordFocusNode,
              enabled: !widget.isLoading,
              keyboardType: TextInputType.visiblePassword,

              onSaved: (val){
                formData.confirmPassword = val ?? "";
              },
              validator: (val) => MatchValidator(errorText: "field_not_match".trParams({
                "base" : "password".tr,
                "target" : "confirm_new_password".tr
              }) ?? "field_not_match").validateMatch(val ?? "", formData.newPassword),
              onFieldSubmitted: (_){
                FocusScope.of(context).unfocus();
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              obscureText: true,
              decoration: kTodoAppInputBorder(
                context,
                label: "confirm_new_password".tr,
                errorText: widget.formError?.first("confirmPassword")?.tr,
                focusNode: formData.confirmPasswordFocusNode
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child:  ElevatedButton(
                onPressed: submitForm,
                style: Theme.of(context).elevatedButtonTheme.style,
                child: widget.isLoading? SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.5,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ) : Text(widget.submitButtonText),


              ),
            )
          ],

        ),
      ),
    );
  }

  void submitForm() {
    if(this._formKey.currentState!.validate()){
      this._formKey.currentState!.save();
      if(this.widget.onSubmit != null){
        this.widget.onSubmit!(this.formData);
      }
    }
  }
}
