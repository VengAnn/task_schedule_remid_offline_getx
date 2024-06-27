import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/controller/onboarding/onboarding_controller.dart';
import 'package:task_remind_offline/routes/route_helper.dart';
import 'package:task_remind_offline/services/share_preferences.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/language_option.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class OnBoardingLanguagePage extends StatelessWidget {
  final bool isHomePage;

  const OnBoardingLanguagePage({
    super.key,
    this.isHomePage = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingController());
    final dimensions = Dimensions(context);

    return Scaffold(
      body: GetBuilder<OnboardingController>(
        builder: (onboardingController) {
          return Padding(
            padding: EdgeInsets.all(dimensions.width20 / 1.5),
            child: SingleChildScrollView(
              child: SizedBox(
                height: dimensions.screenHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    SimpleText(
                      text: 'onboarding_primary_title'.tr,
                      fontWeight: FontWeight.bold,
                      sizeText: dimensions.fontSize21,
                    ),
                    SimpleText(
                      text: 'onboarding_secondary_title'.tr,
                      fontWeight: FontWeight.bold,
                      sizeText: dimensions.fontSize15,
                    ),
                    SizedBox(height: dimensions.height10),
                    Container(
                      width: dimensions.width20 * 13.5,
                      height: dimensions.height20 * 13,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(dimensions.radius10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: dimensions.height5,
                        ),
                        child: SingleChildScrollView(
                          // physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LanguageOption(
                                    onTap: () async {
                                      onboardingController
                                          .setSelectedLanguage("vi");
                                      SharedPreferencesService
                                          .saveSelectedLanguage("vi");
                                      Get.updateLocale(
                                        const Locale('vi'),
                                      );
                                    },
                                    textLanguage: "Tiếng việt",
                                    sizeText: dimensions.fontSize15,
                                    imagePath: "assets/images/vietnam.png",
                                    isSelected:
                                        onboardingController.selectedLanguage ==
                                            "vi",
                                  ),
                                  LanguageOption(
                                    onTap: () async {
                                      onboardingController
                                          .setSelectedLanguage("en");
                                      SharedPreferencesService
                                          .saveSelectedLanguage("en");
                                      Get.updateLocale(const Locale('en'));
                                    },
                                    textLanguage: "English",
                                    sizeText: dimensions.fontSize15,
                                    imagePath:
                                        "assets/images/united-kingdom.png",
                                    isSelected:
                                        onboardingController.selectedLanguage ==
                                            "en",
                                  ),
                                ],
                              ),
                              // cambodia flag
                              Row(
                                children: [
                                  LanguageOption(
                                    onTap: () async {
                                      onboardingController
                                          .setSelectedLanguage("km");
                                      SharedPreferencesService
                                          .saveSelectedLanguage("km");
                                      Get.updateLocale(const Locale('km'));
                                    },
                                    textLanguage: "Khmer",
                                    sizeText: dimensions.fontSize15,
                                    imagePath:
                                        "assets/images/cambodia_flag.png",
                                    isSelected:
                                        onboardingController.selectedLanguage ==
                                            "km",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (isHomePage) {
                                // if true navigate to the calendar page
                                Get.toNamed(RouteHelper.getCalenderPage());
                              } else {
                                Get.toNamed(RouteHelper.getOnBoardingPage());
                              }
                            },
                            child: Container(
                              height: dimensions.height20 * 2,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.green],
                                ),
                                borderRadius: BorderRadius.circular(
                                  dimensions.radius15 * 1.5,
                                ),
                              ),
                              child: Center(
                                child: SimpleText(
                                  text: 'elevated_text'.tr,
                                  fontWeight: FontWeight.bold,
                                  sizeText: dimensions.fontSize15,
                                  textColor: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: dimensions.height20 * 1.4),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
