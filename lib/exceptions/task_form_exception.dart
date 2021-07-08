class FormError {

  Map<String, dynamic> _error = {};

  FormError record(Map<String, List<String>> error){
      this._error = error;
      return this;
  }

  FormError clear(String fieldname){
    if(this._error.containsKey(fieldname)){
      this._error.remove(fieldname);
    }
    return this;
  }

  FormError reset(){
    this._error  = {};
    return this;
  }

  String first(String fieldname){
    if(this._error.containsKey(fieldname)){
      return this._error[fieldname].first();
    }
    return "";
  }
}

class TaskFormException implements Exception {

  String message = "task_form_validation_exception";
  FormError formError = FormError();

  TaskFormException(message);


  @override
  String toString() => message;
}
