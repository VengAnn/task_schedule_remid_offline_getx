import 'package:get/get.dart';
import 'package:task_remind_offline/controller/task/task_controller.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';

class HistoryPageController extends GetxController {
  List<Task> tasksLs = [];
  List<Task> completedLs = [];
  List<Task> notCompletedLs = [];

  bool isLoading = false;

  final TaskController taskController = Get.put(TaskController());

  @override
  void onInit() {
    super.onInit();

    getTaskCompleted();
    getTaskNotCompleted();
    getTaskFromStorage();
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  // get task from local storage
  Future<void> getTaskFromStorage() async {
    tasksLs = [];

    isLoading = true;
    update();
    await taskController.getTasks();

    for (Task task in taskController.taskList) {
      tasksLs.add(task);
    }
    isLoading = false;
    update();
  }

  // get task is completed
  Future<void> getTaskCompleted() async {
    completedLs = [];

    await taskController.getTasks();

    for (Task task in taskController.taskList) {
      if (task.isCompleted == 1) {
        completedLs.add(task);
      }
    }
    update();
  }

  // get task is not completed
  Future<void> getTaskNotCompleted() async {
    notCompletedLs = [];
    await taskController.getTasks();
    for (Task task in taskController.taskList) {
      if (task.isCompleted == 0) {
        notCompletedLs.add(task);
      }
    }
    update();
  }
}
