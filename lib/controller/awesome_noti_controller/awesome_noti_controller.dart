import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:task_remind_offline/main.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/pages/detail_page/detail_page.dart';

class NotificationController {
  /// Handle when a new notification or schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Implement your logic here
  }

  /// Handle when a notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Implement your logic here
  }

  /// Handle when the user dismisses a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Implement your logic here
  }

  /// Handle when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Log the received action details
    log('Received Action:');
    log('Action ID: ${receivedAction.id}');
    log('Action Type: ${receivedAction.actionType}');
    log('Payload: ${receivedAction.payload}');

    if (receivedAction.payload != null) {
      // Deserialize Task from payload
      String? taskStr = receivedAction.payload!['task'];
      Map<String, dynamic> taskMap = jsonDecode(taskStr!);
      Task taskObj = Task.fromJson(taskMap);

      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => DetailTaskPage(task: taskObj)),
      );
      log("Navigated to DetailTaskPage");
    } else {
      log('Payload is null');
    }
  }
}
