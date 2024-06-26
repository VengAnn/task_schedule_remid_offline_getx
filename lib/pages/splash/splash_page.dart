import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_remind_offline/services/share_preferences.dart';
import 'package:task_remind_offline/utils/dimensions.dart';

import '../../routes/route_helper.dart';

// ignore: must_be_immutable
class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // when the animation is completed do this
        bool isExistOnboarding = SharedPreferencesService.loadOnboardingExist();
        if (isExistOnboarding) {
          Get.offAllNamed(
            RouteHelper.getCalenderPage(),
          );
        } else {
          Get.offAllNamed(
            RouteHelper.getOnBoardingLanguagePage(),
            arguments: false,
          );
        }
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the AnimationController here

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0), // Slide from right
                end: Offset.zero, // To the center
              ).animate(animation),
              child: Lottie.asset(
                'assets/animations/logo_animation.json',
                // width: 100,
                // height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: dimensions.height10),
          Center(
            child: Text(
              'splash_text'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
