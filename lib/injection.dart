import 'package:get/get.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/controller/onboarding/onboarding_controller.dart';
import 'package:task_remind_offline/controller/storage_page_controller/db_size_info_page_controller.dart';
import 'package:task_remind_offline/controller/task/task_controller.dart';

// ignore: non_constant_identifier_names
Future<void> init_Dependency_Injection() async {
  //api client

  //repositories

  // Register all controllers
  Get.lazyPut<CalendarPageController>(() => CalendarPageController());
  Get.lazyPut<OnboardingController>(() => OnboardingController());

  Get.lazyPut<TaskController>(() => TaskController());
  Get.lazyPut<StoragePageController>(() => StoragePageController());
}
