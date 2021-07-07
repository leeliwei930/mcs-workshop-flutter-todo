
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:todo/models/task.dart';

class TasksProvider extends GetConnect {


  @override
  void onInit() {
    if(kDebugMode){
      httpClient.baseUrl = dotenv.env['STRAPI_DEBUG_ENDPOINT'];
    } else {
      httpClient.baseUrl = dotenv.env['STRAPI_PRODUCTION_ENDPOINT'];
    }
    httpClient.errorSafety = false;
  }

  Future<Task?> findTask(String id) async {
    try {
      Response response = await httpClient.get('/tasks/$id');

      Task task = Task.fromJson(response.body);
      return Future.value(task);


    } catch ( exception, stackTrace){
        //exception can be GetHttpException or SocketException
        Future.error(exception, stackTrace);
    }
  }

  getTasks(){

  }


}
