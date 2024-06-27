import 'package:flutter/material.dart';
import 'package:task_remind_offline/utils/app_color.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class OnBoardingWidget extends StatelessWidget {
  final String imageAsset;
  final String text;

  const OnBoardingWidget({
    super.key,
    required this.imageAsset,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: dimensions.screenWidth,
              height: dimensions.screenHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                ),
              ),
            ),
            Positioned(
              top: dimensions.screenHeight / 3.5,
              child: Container(
                width: dimensions.screenWidth,
                height: dimensions.height20 * 15,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan,
                      Colors.blueGrey,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.elliptical(10, 10),
                  ),
                ),
              ),
            ),
            Container(
              width: dimensions.screenWidth,
              height: dimensions.screenHeight / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(dimensions.height20 * 10),
                  bottomRight: const Radius.elliptical(10, 10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: dimensions.width10,
                      bottom: dimensions.height10 * 2,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(dimensions.radius15),
                      child: Image.asset(
                        imageAsset,
                        width: dimensions.height20 * 14,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: dimensions.screenHeight / 1.8,
              child: Column(
                children: [
                  SizedBox(
                    width: dimensions.screenWidth,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: dimensions.width10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SimpleText(
                              text: text,
                              fontWeight: FontWeight.w600,
                              textColor: AppColor.colorWhite,
                              sizeText: dimensions.fontSize21 / 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
