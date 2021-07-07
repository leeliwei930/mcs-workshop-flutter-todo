import 'package:get/get.dart';

class TasksController extends GetxController {

  RxInt number = 0.obs;

  void decrease(){
    this.number--;
  }


}
