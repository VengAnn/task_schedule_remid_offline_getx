import 'package:get/get.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/services/databaseHelper/database_helper.dart';

class TaskController extends GetxController {
  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  List<Task> taskList = [];

  // function pass task to dbHelper
  Future<int> addTask({Task? task}) async {
    return await DBHelper.dbInsert(task!);
  }

  //get all the data from table
  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    print("task controller : $tasks");

    // the data tasks return is map we need convert to obj and loop each obj add it to taskList
    taskList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
    update();
  }

  // delele tasks
  void delele(Task task) {
    DBHelper.delete(task);

    // delete ok refresh list agian
    getTasks();
  }

  // update tasks
  void updateTask(Task task) {
    DBHelper.updateTask(task);
    getTasks();
  }

  // update tasks completed
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
