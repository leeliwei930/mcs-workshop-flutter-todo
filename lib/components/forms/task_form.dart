import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:todo/constants/default_theme.dart';
import 'package:todo/constants/input_border.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:todo/exceptions/task_form_exception.dart';
import 'package:todo/models/task.dart';

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
  bool isLoading = false;
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

                  enabled: !widget.isLoading,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (val){
                    value.title = val ?? "";
                  },
                  validator: (val){
                    if(widget.formError != null){
                      return widget.formError!.first("title");
                    }
                    var titleValidator = MultiValidator([
                      RequiredValidator(errorText: 'Title field is required'),
                      LengthRangeValidator(min: 3, max: 255, errorText: "Title field is must be between 3 to 255 characters."),
                    ]);
                    var isValid = titleValidator.isValid(val);
                    this.hasFieldsError = !isValid;
                    return titleValidator.call(val ?? "");
                  },
                  initialValue:  value.title,
                  cursorColor: accentColor,
                  focusNode: FocusNode(
                      canRequestFocus: false
                  ),
                  decoration: kTodoAppInputBorder(label: "Title")
                ),
                SizedBox(height: 15,),
                TextFormField(
                    enabled: !widget.isLoading,
                    minLines: 5,
                    maxLines: 5,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onSaved: (val){
                      value.description = val;
                    },
                    validator: (val) {
                      if(widget.formError != null){
                        return widget.formError!.first("description");
                      }
                      var descriptionValidator =  MultiValidator([
                        MaxLengthValidator(65535, errorText: "Description cannot be over 65535 characters.")
                      ]);
                      this.hasFieldsError = !descriptionValidator.isValid(val);
                      return descriptionValidator.call(val ?? "");
                    },
                    cursorColor: accentColor,
                    initialValue: value.description,
                    focusNode: FocusNode(
                        canRequestFocus: false
                    ),
                    decoration: kTodoAppInputBorder(label: "Description")
                ),
              Row(
                children: [
                  Switch(

                    value: hasDueDate,
                    onChanged: (value){
                      setState(() {
                        this.hasDueDate = value;
                      });
                    },

                  ),
                  Text("Set a due date for this task")
                ],
              ),
                if(hasDueDate) DateTimeField(
                  enabled: !widget.isLoading,
                  initialValue: value.dueDate ,
                  onSaved: (val){
                    value.dueDate = val;
                  },
                  decoration: kTodoAppInputBorder(label: "Due At"),
                  format: DateFormat.yMEd().add_jms(),
                  validator: (DateTime? datetime){
                    if(widget.formError != null){
                      return widget.formError!.first("title");
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
                        Text("Mark this task as complete")
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
                  ) : Text("Create Task"),

                  onPressed: hasFieldsError || widget.isLoading ? null :  (){
                    setState(() {

                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        if(widget.onSubmit != null){
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

