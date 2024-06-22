import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/routes/route_helper.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/item_drawer_widget.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: Dimensions.width20 * 20,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //logo header
              Padding(
                padding: EdgeInsets.only(
                  top: Dimensions.width20 * 2,
                  left: Dimensions.width10,
                ),
                child: Center(
                  child: Image(
                    width: Dimensions.width20 * 10,
                    image: const AssetImage("assets/images/calendar.gif"),
                  ),
                ),
              ),
              // Divider
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20),
                child: const Divider(
                  thickness: 2,
                ),
              ),
              // day tile
              ItemDrawerWidget(
                onTap: () {
                  Get.find<CalendarPageController>()
                      .setCalendarView(CalendarView.day);
                  Get.back();
                },
                text: "day_text".tr,
                icon: Icons.calendar_view_day_outlined,
              ),
              // week tile
              ItemDrawerWidget(
                onTap: () {
                  Get.find<CalendarPageController>()
                      .setCalendarView(CalendarView.week);
                  Get.back();
                },
                text: "week_text".tr,
                icon: Icons.calendar_view_week_outlined,
              ),

              // Month tile
              ItemDrawerWidget(
                onTap: () {
                  Get.find<CalendarPageController>()
                      .setCalendarView(CalendarView.month);
                  // pop drawer
                  Navigator.of(context).pop();
                },
                text: "month_text".tr,
                icon: Icons.calendar_month_outlined,
              ),

              // history
              ItemDrawerWidget(
                onTap: () {
                  // when click this close drawer(by Get.back()) and go to page history
                  Get.back();
                  Get.toNamed(
                    RouteHelper.getHistoryPage(),
                  );
                },
                text: "history_text".tr,
                icon: Icons.history,
              ),
              // settings
              // change language
              ItemDrawerWidget(
                onTap: () {
                  // when click this close drawer(by Get.back()) and go to page change language
                  Get.back();
                  Get.toNamed(
                    RouteHelper.getOnBoardingLanguagePage(),
                    arguments: true,
                  );
                },
                text: "change_language_text".tr,
                icon: Icons.language_outlined,
              ),
              ItemDrawerWidget(
                onTap: () {
                  Get.back();
                  // when click this close drawer(by Get.back()) and go to page data and storage
                  Get.toNamed(RouteHelper.getDatabaseSizeInfoPage());
                },
                icon: Icons.data_saver_off_outlined,
                text: "data_and_storage_text".tr,
              ),
              // data and storage
            ],
          ),
        ),
      ),
    );
  }
}
