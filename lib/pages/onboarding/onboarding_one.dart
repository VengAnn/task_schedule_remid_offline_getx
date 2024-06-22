import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/widgets/onboarding_widget.dart';

class OnBoardingPageOne extends StatelessWidget {
  const OnBoardingPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
      imageAsset: "assets/images/image_calendar_1.jpg",
      text: 'onboarding_one_text'.tr,
    );
  }
}
