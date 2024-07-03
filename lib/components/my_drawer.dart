import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/routes/route_helper.dart';
import 'package:task_remind_offline/services/share_preferences.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/item_drawer_widget.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // if load Drawer tapped Index null is default = 0 of index
  int _activeIndex = SharedPreferencesService.loadDrawerTappedIndex();

  void _onTap(int index, VoidCallback onTap) {
    setState(() {
      _activeIndex = index;
    });
    Future.delayed(const Duration(milliseconds: 100), onTap);
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return SafeArea(
      child: Drawer(
        width: dimensions.width20 * 17,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // logo header
              Padding(
                padding: EdgeInsets.only(
                  top: dimensions.width20 * 2,
                  left: dimensions.width10,
                ),
                child: Center(
                  child: Image(
                    width: dimensions.width20 * 10,
                    image: const AssetImage("assets/images/calendar.gif"),
                  ),
                ),
              ),
              // Divider
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensions.width20,
                    vertical: dimensions.height20),
                child: const Divider(
                  thickness: 2,
                ),
              ),
              // day tile
              ItemDrawerWidget(
                onTap: () {
                  SharedPreferencesService.clearDrawerTappedIndex();
                  SharedPreferencesService.saveDrawerTappedIndex(0);
                  _onTap(0, () {
                    Get.find<CalendarPageController>()
                        .setCalendarView(CalendarView.day);
                    Get.back();
                  });
                },
                text: "day_text".tr,
                icon: Icons.calendar_view_day_outlined,
                isActive: _activeIndex == 0,
              ),
              // week tile
              ItemDrawerWidget(
                onTap: () {
                  SharedPreferencesService.clearDrawerTappedIndex();
                  SharedPreferencesService.saveDrawerTappedIndex(1);
                  _onTap(1, () {
                    Get.find<CalendarPageController>()
                        .setCalendarView(CalendarView.week);
                    Get.back();
                  });
                },
                text: "week_text".tr,
                icon: Icons.calendar_view_week_outlined,
                isActive: _activeIndex == 1,
              ),
              // month tile
              ItemDrawerWidget(
                onTap: () {
                  SharedPreferencesService.clearDrawerTappedIndex();
                  SharedPreferencesService.saveDrawerTappedIndex(2);
                  _onTap(2, () {
                    Get.find<CalendarPageController>()
                        .setCalendarView(CalendarView.month);
                    Navigator.of(context).pop();
                  });
                },
                text: "month_text".tr,
                icon: Icons.calendar_month_outlined,
                isActive: _activeIndex == 2,
              ),
              // history
              ItemDrawerWidget(
                onTap: () {
                  // SharedPreferencesService.clearDrawerTappedIndex();
                  // SharedPreferencesService.saveDrawerTappedIndex(3);
                  _onTap(3, () {
                    Get.back();
                    Get.toNamed(
                      RouteHelper.getHistoryPage(),
                    );
                  });
                },
                text: "history_text".tr,
                icon: Icons.history,
                isActive: _activeIndex == 3,
              ),
              // change language
              ItemDrawerWidget(
                onTap: () {
                  // SharedPreferencesService.clearDrawerTappedIndex();
                  // SharedPreferencesService.saveDrawerTappedIndex(4);
                  _onTap(4, () {
                    Get.back();
                    Get.toNamed(
                      RouteHelper.getOnBoardingLanguagePage(),
                      arguments: true,
                    );
                  });
                },
                text: "change_language_text".tr,
                icon: Icons.language_outlined,
                isActive: _activeIndex == 4,
              ),
              // data and storage
              ItemDrawerWidget(
                onTap: () {
                  // SharedPreferencesService.clearDrawerTappedIndex();
                  // SharedPreferencesService.saveDrawerTappedIndex(5);
                  _onTap(5, () {
                    Get.back();
                    Get.toNamed(RouteHelper.getDatabaseSizeInfoPage());
                  });
                },
                icon: Icons.data_saver_off_outlined,
                text: "data_and_storage_text".tr,
                isActive: _activeIndex == 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
