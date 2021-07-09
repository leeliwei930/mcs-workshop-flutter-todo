
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/auth_service.dart';

class TasksProvider extends GetConnect {

  late AuthService _authService;

  @override
  TasksProvider onInit() {
    if(kDebugMode){
      httpClient.baseUrl = dotenv.env['STRAPI_DEBUG_ENDPOINT'];
    } else {
      httpClient.baseUrl = dotenv.env['STRAPI_PRODUCTION_ENDPOINT'];
    }
    httpClient.errorSafety = false;
    this._authService = Get.find<AuthService>();
    if(this._authService.isAuthenticated()){
      httpClient.addRequestModifier((Request request) async {
        request.headers['Authorization'] = "Bearer ${await this._authService.getExistingJWT()}";

        return request;
      });
    }
    return this;
  }

  Future<Response> findTask(String id){
    return get('/tasks/$id');
  }

  Future<Response> fetchTasks(bool? completed){
    if(completed != null){
      return get('/tasks', query: {
        "completed" : completed
      });
    }
    return get('/tasks');
  }

  Future<Response> deleteTask(String id){
    return delete('/tasks/$id');
  }

  Future<Response> updateTask(String id, Task updatedTask) {
    return put('/tasks/$id',  updatedTask.toJson());
  }

  Future<Response> createTask(Task task){
    return post('/tasks', task.toJson());
  }

}
