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
  bool hasDueDate = false; // use to control due_date DateTimeFormField dynamically
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if the initial value is set
    if(widget.initialValue != null){
      // bring the initialValue that is set from the widget constructor to current state
      this.value = widget.initialValue!;
      this.hasDueDate =  value.dueDate != null;

    } else {

      this.value = Task(
        id: "",
        completed: false,
        title: "",
      );
    }

    // Focus Node listener, update the focus node UI state when
    // text field focus state changed.
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  enabled: !widget.isLoading,
                  onSaved: (val){
                    value.title = val ?? "";
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'field_required'.trParams({
                      "name" : "title".tr
                    }) ?? ""),
                    LengthRangeValidator(min: 3, max: 255, errorText: "field_range".trParams({
                      "name" : "title".tr.capitalizeFirst!,
                      "min" : "3",
                      "max" : "255"
                    }) ?? ""),
                  ]),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    enabled: !widget.isLoading,
                    minLines: 5,
                    maxLines: 5,
                    focusNode: value.descriptionFocusNode,

                    onSaved: (val){
                      value.description = val;
                    },
                    validator: MultiValidator([
                      MaxLengthValidator(65535, errorText: "field_max".trParams({
                        "name" : "description".tr.capitalizeFirst!,
                        "max" : "65535"
                      }) ?? "")
                    ]),
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
                  decoration: kTodoAppInputBorder(
                      context,
                      label: "due_at".tr,
                      focusNode: value.dueDateFocusNode,
                      errorText:  widget.formError?.first("due_date")
                  ),
                  format: DateFormat.yMEd().add_jms(),

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

                  onPressed:  widget.isLoading ? null :  (){
                    setState(() {
                      // validate the form
                      if(_formKey.currentState!.validate()){
                        // if form is valid save it
                        _formKey.currentState!.save();
                        // perform a onSubmit callback if it is not null
                        if(widget.onSubmit != null){
                          // if there is no due date set
                          if(!this.hasDueDate){
                            // set the value of task due date to null
                            value.dueDate = null;
                          }
                          // callback with submit value argument
                          widget.onSubmit!(value) ;
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

