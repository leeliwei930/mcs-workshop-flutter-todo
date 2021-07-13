import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:todo/exceptions/form_exception.dart';
import 'package:get/get.dart';
void toastException(Object error, BuildContext context){
  if(error is SocketException || error is GetHttpException) {
    if(error.toString() == "incorrect_account_credentials"){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("incorrect_account_credentials".tr)));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("network_error".tr)));
  } else if (error is TimeoutException) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("network_timeout_error".tr)));
  } else  if (error is FormException) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message.tr)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("unknown_error".tr)));
  }
}
