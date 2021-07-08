import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:todo/controllers/tasks_provider.dart';
import 'package:todo/exceptions/task_form_exception.dart';
import 'package:todo/models/task.dart';

class TasksController extends GetxController {


  RxList<Task> tasks = List<Task>.of([]).obs;
  late TasksProvider _provider;

  RxBool taskListLoading = false.obs;
  RxBool taskLoading = false.obs;
  RxBool createTaskLoading = false.obs;
  RxBool updateTaskLoading = false.obs;
  RxBool deleteTaskLoading = false.obs;

  Rx<Task?> task = null.obs;
  @override
  void onInit() {
    this._provider = TasksProvider().onInit();
  }

  Future<List<Task>> fetchAllTasks() async {
      this.taskListLoading.value = true;
      try {
        Response response = await _provider.fetchTasks();
        List<Map<String, dynamic>> data = response.body['data'];
        data.forEach((task) {
          tasks.add(Task.fromJson(task));
        });
        this.taskListLoading.value = false;
        return Future.value(tasks);
      } catch (error, stackTrace) {
        this.taskListLoading.value = false;
        return Future.error(error, stackTrace);
      }
  }

  Future<List<Task>>fetchCompletedTasks() async {
    this.taskListLoading.value = true;
    try {
      Response response = await _provider.fetchTasks(completed: true);
      List<Map<String, dynamic>> data = response.body['data'];
      data.forEach((task) {
        tasks.add(Task.fromJson(task));
      });
      this.taskListLoading.value = false;
      return Future.value(tasks);
    } catch (error, stackTrace) {
      this.taskListLoading.value = false;
      return Future.error(error, stackTrace);
    }
  }

  Future<List<Task>> fetchUncompletedTasks() async {
    this.taskListLoading.value = true;
    try {
      Response response = await _provider.fetchTasks(completed: false);
      List<Map<String, dynamic>> data = response.body['data'];
      data.forEach((task) {
        tasks.add(Task.fromJson(task));
      });
      this.taskListLoading.value = false;
      return Future.value(tasks);
    } catch (error, stackTrace) {
      this.taskListLoading.value = false;
      return Future.error(error, stackTrace);
    }
  }

  Future<Task> findTask(int id) async {
    this.taskLoading.value = true;
    try {
      Response response = await _provider.findTask(id);
      Task task = Task.fromJson(response.body);
      this.taskLoading.value = false;
      return Future.value(task);

    } catch (error, stackTrace){
      this.taskLoading.value = false;
      return Future.error(error, stackTrace);
    }

  }

  Future<Task> updateTask(int id, Task updatedTask) async {
    this.updateTaskLoading.value = true;
    try {
      Response response = await _provider.updateTask(id, updatedTask);
      if(response.isOk) {
        Task task = Task.fromJson(response.body);
        this.updateTaskLoading.value = false;
        return Future.value(task);
      } else if(response.statusCode ==  HttpStatus.badRequest){
        TaskFormException exception = TaskFormException("validation_exception");
        exception.formError.record(response.body['data']['errors']);
        throw exception;
      }
      throw GetHttpException("server_error");
    } catch (error, stackTrace){
      this.updateTaskLoading.value = false;
      return Future.error(error, stackTrace);
    }

  }

  Future<Task> createTask(Task newTask) async {
    this.createTaskLoading.value = true;
    try {
      Response response = await _provider.createTask(newTask);
      if(response.isOk){
        Task task = Task.fromJson(response.body);
        this.createTaskLoading.value = false;
        return Future.value(task);

      } else if(response.statusCode ==  HttpStatus.badRequest){
        TaskFormException exception = TaskFormException("validation_exception");
        exception.formError.record(response.body['data']['errors']);
        throw exception;
      }
      throw GetHttpException("server_error");
    } catch (error, stackTrace){
      this.createTaskLoading.value = false;
      return Future.error(error, stackTrace);
    }
  }

  Future<Task> deleteTask(int id) async {
    this.deleteTaskLoading.value = true;
    try {
      Response response = await _provider.deleteTask(id);
      Task task = Task.fromJson(response.body);
      this.deleteTaskLoading.value = false;
      return Future.value(task);
    } catch (error, stackTrace){
      this.deleteTaskLoading.value = false;
      return Future.error(error, stackTrace);
    }
  }
}
