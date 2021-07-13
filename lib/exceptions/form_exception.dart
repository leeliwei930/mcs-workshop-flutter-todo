class FormError {

  Map<String, dynamic> _error = {};

  // record all the form validator errors message from server
  FormError record(Map<String, dynamic> error){
      this._error = error;
      return this;
  }

  // clear a specific error on existing _error Map
  FormError clear(String fieldname){
    if(this._error.containsKey(fieldname)){
      this._error.remove(fieldname);
    }
    return this;
  }

  // reset the error map
  FormError reset(){
    this._error  = {};
    return this;
  }

  // grab the first error
  String? first(String fieldname){
    if(this._error.containsKey(fieldname)){
      return this._error[fieldname][0];
    }
    return null;
  }
}

class FormException implements Exception {

  String message = "form_validation_exception";
  FormError formError = FormError();

  FormException(message);


  @override
  String toString() => message;
}
