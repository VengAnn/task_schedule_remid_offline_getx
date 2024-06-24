import 'package:get/get.dart';
import 'package:task_remind_offline/controller/task/task_controller.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';

class StoragePageController extends GetxController {
  final TaskController taskController = Get.put(TaskController());

  final List<Task> tasksList = [];

  @override
  void onInit() {
    super.onInit();

    getTaskFromStorage();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getTaskFromStorage() async {
    await taskController.getTasks();

    for (Task task in taskController.taskList) {
      tasksList.add(task);
    }
    update();
  }

  // clear storage sqlite
  Future<void> clearStorage() async {
    taskController.clearAllTask();
    tasksList.clear();
    update();
  }
}
