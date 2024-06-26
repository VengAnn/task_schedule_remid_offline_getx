import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  static void showSnackBar(String message,
      {String title = 'Info',
      SnackPosition position = SnackPosition.BOTTOM,
      int? durationMilliseconds}) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: durationMilliseconds == null
          ? const Duration(seconds: 3)
          : Duration(milliseconds: durationMilliseconds),
    );
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void hideProgressBar(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
