import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/widgets/onboarding_widget.dart';

class OnBoardingPageTwo extends StatelessWidget {
  const OnBoardingPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
      imageAsset: "assets/images/image_calendar_2.jpg",
      text: 'onboarding_two_text'.tr,
    );
  }
}
