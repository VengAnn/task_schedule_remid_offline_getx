import 'package:get/get.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';

// ignore: non_constant_identifier_names
Future<void> init_Dependency_Injection() async {
  //api client

  //repositories

  // Register all controllers
  Get.lazyPut(() => CalendarPageController());
}
