import 'package:get/get.dart';
import 'package:task_remind_offline/controller/task/task_controller.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';

class StoragePageController extends GetxController {
  final TaskController taskController = Get.put(TaskController());

  List<Task> tasksList = [];

  @override
  void onInit() {
    super.onInit();

    getTaskFromStorage();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  Future<void> getTaskFromStorage() async {
    tasksList = [];
    await taskController.getTasks();

    for (Task task in taskController.taskList) {
      tasksList.add(task);
    }
    update();
  }

  // clear storage sqlite
  void clearStorage() {
    taskController.clearAllTask();
    tasksList.clear();
    update();
  }
}
