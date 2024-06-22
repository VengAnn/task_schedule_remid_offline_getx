import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_remind_offline/components/dialogs.dart';
import 'package:task_remind_offline/controller/task/task_controller.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/services/awesome_notification.dart';

class CalendarPageController extends GetxController {
  late DateTime startTime;
  late DateTime endTime;

  List<Appointment> appointments = [];

  // this for change calendar view day or week or month
  CalendarView calendarView = CalendarView.day;

  final CalendarController calendarController = CalendarController();
  final TaskController taskController = Get.put(TaskController());

  @override
  void onInit() {
    super.onInit();

    initializeTimes();
    getTaskFromTaskController();
  }

  void initializeTimes() {
    // Get the current datetime
    DateTime currentDate = DateTime.now();
    // Initialize and set the default to current
    startTime = DateTime(currentDate.year, currentDate.month, currentDate.day);
    endTime = DateTime(currentDate.year, currentDate.month, currentDate.day);
  }

  Future<void> getDataLocalForAlerNotification() async {
    await taskController.getTasks();

    for (Task task in taskController.taskList) {
      alertNotification(task: task);
    }
  }

  // alert awesome schedule notification
  void alertNotification({required Task task}) {
    try {
      if (task.date == null ||
          task.startTime == null ||
          task.title == null ||
          task.note == null) {
        throw const FormatException('Date, Start Time, Title, or Note is null');
      }

      DateTime taskDateTime = DateFormat("yyyy-MM-dd hh:mm a")
          .parse("${task.date} ${task.startTime}");
      DateTime now = DateTime.now();

      if (taskDateTime.isAfter(now)) {
        if (task.repeat == "None") {
          log("Task : id :${task.id} startTIme: ${task.startTime}, repeat : ${task.repeat}, task : ${task.remind}");
          // Subtract the reminder time from the taskDateTime if remind is not 0 and not null
          if (task.remind != null && task.remind != 0) {
            int remindMinutes = task.remind!;
            taskDateTime =
                taskDateTime.subtract(Duration(minutes: remindMinutes));
          }

          AwesomeNotificationHelper.scheduleNotificationWithDateTime(
            task: task,
            title: task.title!,
            body: task.note!,
            year: taskDateTime.year,
            month: taskDateTime.month,
            day: taskDateTime.day,
            hour: taskDateTime.hour,
            minute: taskDateTime.minute,
            summary: 'Something New',
          );
        } else if (task.repeat == "Daily") {
          // Handle repeating notifications
          log("Task : ${task.startTime}, repeat : ${task.repeat}, task : ${task.remind}");
          AwesomeNotificationHelper.scheduleDailyNotification(
            task: task,
            title: task.title!,
            body: task.note!,
            hour: taskDateTime.hour,
            minute: taskDateTime.minute,
            summary: 'Something New',
          );
        }
      }
    } catch (e) {
      log("Error in alertNotification: $e");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Dialogs.showSnackBar("Error in alertNotification: $e");
      });
    }
  }

  // void deleteLocalStorageNotCurrentlyDateTime({required Task task}) {
  //   // delete local storage if not currently date time
  //   DateTime taskDateTime = DateFormat("yyyy-MM-dd hh:mm a")
  //       .parse("${task.date} ${task.startTime}");
  //   DateTime now = DateTime.now();
  //   // Check if the task's date and time are in the past
  //   if (taskDateTime.isBefore(now)) {
  //     taskController.delele(task);
  //   }
  // }

  // ignore: unused_element
  Future<void> getTaskFromTaskController() async {
    await taskController.getTasks();

    // Convert all tasks to appointments and update
    appointments = getEventTaskAsAppointments(taskController.taskList);
    update();
  }

  // Function to convert eventTask to appointments
  List<Appointment> getEventTaskAsAppointments(List<Task> taskList) {
    List<Appointment> appointmentsLocal = [];

    for (Task task in taskList) {
      // Parse the time string to a DateTime object using DateFormat
      DateTime startTime = DateFormat("yyy-MM-dd hh:mm a")
          .parse("${task.date} ${task.startTime}");
      DateTime endTime =
          DateFormat("yyy-MM-dd hh:mm a").parse("${task.date} ${task.endTime}");

      appointmentsLocal.add(
        Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: task.title ?? '',
          color: task.color == 0
              ? Colors.blue
              : task.color == 1
                  ? Colors.pink
                  : Colors.yellow,
          id: task.id,
          notes: task.note,
          isAllDay: task.repeat == 'Daily' ? true : false,
          resourceIds: taskList,
        ),
      );
    }
    return appointmentsLocal;
  }

  // void change calendar view or month
  void setCalendarView(CalendarView view) {
    // log("Changed view: $view");
    calendarView = view;
    update();
    calendarController.view = calendarView;
  }

  void jumpToToday() {
    calendarController.displayDate = DateTime.now();
    update();
  }
}
