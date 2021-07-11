import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                obscureText: true,
                onSaved: (value){
                  formData.password = value?? "";
                },
                enabled: !widget.isLoading,
                keyboardType: TextInputType.text,
                decoration: kTodoAppInputBorder(
                    label: "current_password".tr,
                    errorText:  widget.formError?.first("password")
                )
            ),
            SizedBox(height: 10,),
            TextFormField(
              enabled: !widget.isLoading,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onSaved: (val){
                formData.newPassword = val ?? "";
              },
              decoration: kTodoAppInputBorder(
                label: "new_password".tr,
                errorText: widget.formError?.first("newPassword")
            ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              enabled: !widget.isLoading,
              keyboardType: TextInputType.visiblePassword,
              onSaved: (val){
                formData.confirmPassword = val ?? "";
              },
              autocorrect: false,
              obscureText: true,
              decoration: kTodoAppInputBorder(
                label: "confirm_new_password".tr,
                errorText: widget.formError?.first("confirmPassword")
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
                    color: Theme.of(context).accentColor,
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
