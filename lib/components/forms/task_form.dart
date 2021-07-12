import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:todo/constants/default_theme.dart';
import 'package:todo/constants/input_border.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:todo/exceptions/form_exception.dart';
import 'package:todo/models/task.dart';
import 'package:get/get.dart';
class TaskForm extends StatefulWidget {
  final String submitButtonText;
  final Function? onSubmit;
  final Function? onSubmitFailed;
  final Task? initialValue;
  final bool isLoading;
  final FormError? formError;
  const TaskForm({Key? key, required this.submitButtonText, this.onSubmit,  this.onSubmitFailed, this.initialValue, this.isLoading = false, this.formError}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {

  late Task value;
  bool hasDueDate = false;
  bool hasFieldsError = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.initialValue != null){

      this.value = widget.initialValue!;
      this.hasDueDate =  value.dueDate != null;

    } else {

      this.value = Task(
        id: "",
        completed: false,
        title: "",
      );
    }

    this.value.titleFocusNode.addListener(() {setState(() {

    });});
    this.value.descriptionFocusNode.addListener(() {setState(() {

    });});
    this.value.dueDateFocusNode.addListener(() {setState(() {

    });});
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  enabled: !widget.isLoading,
                  onSaved: (val){
                    value.title = val ?? "";
                  },
                  validator: (val){
                    var titleValidator = MultiValidator([
                      RequiredValidator(errorText: 'field_required'.trParams({
                        "name" : "title".tr
                      }) ?? ""),
                      LengthRangeValidator(min: 3, max: 255, errorText: "field_range".trParams({
                        "name" : "title".tr.capitalizeFirst!,
                        "min" : "3",
                        "max" : "255"
                      }) ?? ""),
                    ]);
                    var isValid = titleValidator.isValid(val);
                    this.hasFieldsError = !isValid;
                    return titleValidator.call(val ?? "");
                  },
                  initialValue:  value.title,
                  cursorColor: accentColor,
                  focusNode: value.titleFocusNode,
                  decoration: kTodoAppInputBorder(context, label: "title".tr, errorText:  widget.formError?.first("title"), focusNode: value.titleFocusNode),
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(value.descriptionFocusNode);
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    enabled: !widget.isLoading,
                    minLines: 5,
                    maxLines: 5,
                    focusNode: value.descriptionFocusNode,

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (val){
                      value.description = val;
                    },
                    validator: (val) {
                      var descriptionValidator =  MultiValidator([
                        MaxLengthValidator(65535, errorText: "field_max".trParams({
                          "name" : "description".tr.capitalizeFirst!,
                          "max" : "65535"
                        }) ?? "")
                      ]);
                      this.hasFieldsError = !descriptionValidator.isValid(val);
                      return descriptionValidator.call(val ?? "");
                    },
                    cursorColor: accentColor,
                    initialValue: value.description,
                    decoration: kTodoAppInputBorder(context, label: "description".tr, errorText: widget.formError?.first("description"), focusNode: value.descriptionFocusNode,)
                ),
              Row(
                children: [
                  Switch(

                    value: hasDueDate,
                    onChanged: (val){
                      setState(() {
                        this.hasDueDate = val;
                      });
                    },

                  ),
                  Text("set_due_date".trParams({
                    "type" : "task".tr
                  }) ?? "")
                ],
              ),
                if(hasDueDate) DateTimeField(
                  textInputAction: TextInputAction.next,
                  enabled: !widget.isLoading,
                  focusNode: value.dueDateFocusNode,
                  initialValue: value.dueDate ,
                  onSaved: (val){
                    value.dueDate = val;
                  },
                  decoration: kTodoAppInputBorder(context, label: "due_at".tr, focusNode: value.dueDateFocusNode,),
                  format: DateFormat.yMEd().add_jms(),
                  validator: (DateTime? datetime){
                    if(widget.formError != null){
                      return widget.formError!.first("due_date");
                    }
                  },
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),

                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),

                      );
                      return DateTimeField.combine(date, time);
                    } else {
                      return currentValue;
                    }
                  },),

                FormField<bool>(
                  onSaved: (val){
                    value.completed = val ?? false;
                  },
                  initialValue: value.completed,
                  builder: (FormFieldState<bool> field){

                    return Row(
                      children: [
                        Switch(
                        value: field.value ?? false,
                          onChanged: (bool value) {
                            if(!widget.isLoading){
                              field.didChange(value);
                            }
                          },
                        ),
                        Text("mark_as_completed".trParams({
                          "type" : "task".tr
                        }) ?? "")
                      ],
                    );
                  },


                ),
                ElevatedButton(

                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: widget.isLoading? SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.5,
                      color: Theme.of(context).accentColor,
                    ),
                  ) : Text(widget.submitButtonText),

                  onPressed: hasFieldsError || widget.isLoading ? null :  (){
                    setState(() {

                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        if(widget.onSubmit != null){
                          if(!this.hasDueDate){
                            value.dueDate = null;
                          }
                          widget.onSubmit!(value) ;
                        }
                      } else {
                        this.hasFieldsError = true;
                        if(widget.onSubmitFailed != null){
                          widget.onSubmitFailed!() ;
                        }
                      }
                    });
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

}

