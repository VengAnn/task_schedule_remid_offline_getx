import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_remind_offline/components/dialog_show.dart';
import 'package:task_remind_offline/components/my_drawer.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body:
          GetBuilder<CalendarPageController>(builder: (calendarPageController) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  //
                  Container(
                    height: Dimensions.height20 * 2.7,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.amber,
                          Colors.blue,
                          Colors.black,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          icon: const Icon(Icons.menu),
                        ),
                        Text(
                          'title_appbar_text'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.fontSize20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              calendarPageController.jumpToToday();
                            },
                            child: CircleAvatar(
                              radius: Dimensions.radius20 * 1.2,
                              backgroundColor: Colors.blue,
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                radius: Dimensions.radius15 * 1.2,
                                child: SimpleText(
                                  text: "text_Today".tr,
                                  sizeText: Dimensions.fontSize15 / 1.4,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )),
                        SizedBox(width: Dimensions.width10),
                      ],
                    ),
                  ),
                  // show calendar full screen if view week
                  calendarPageController.calendarView == CalendarView.week
                      ? const Expanded(
                          child: showCalendar(),
                        )
                      : calendarPageController.calendarView == CalendarView.day
                          ? const Expanded(
                              child: showCalendar(),
                            )
                          :
                          // calendar view month show a bit heigth
                          const Expanded(
                              child: SizedBox(
                                child: showCalendar(),
                              ),
                            ),
                ],
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ignore: camel_case_types
class showCalendar extends StatelessWidget {
  const showCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarPageController>(
        builder: (calendarPageController) {
      return SfCalendar(
        controller: Get.find<CalendarPageController>().calendarController,
        onTap: (CalendarTapDetails details) {},
        view: Get.find<CalendarPageController>().calendarView,
        onSelectionChanged: (CalendarSelectionDetails details) {},
        dataSource: DataSource(calendarPageController.appointments),
        headerStyle: CalendarHeaderStyle(
          textAlign: TextAlign.center,
          backgroundColor: Colors.grey[300],
          textStyle: TextStyle(
            fontSize: Dimensions.fontSize20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(
            fontSize: Dimensions.fontSize15,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          dateTextStyle: TextStyle(
            fontSize: Dimensions.fontSize15,
            color: Colors.red,
          ),
        ),
        monthViewSettings: MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
          showAgenda: true,
          agendaViewHeight: Dimensions.height20 * 15,
          agendaStyle: AgendaStyle(
            backgroundColor: Colors.blue[200],
            dayTextStyle: TextStyle(
              fontSize: Dimensions.fontSize15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            dateTextStyle: TextStyle(
              fontSize: Dimensions.fontSize15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        todayHighlightColor: Colors.orange,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(Dimensions.width10),
        ),
      );
    });
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

//
// ignore: unused_element
void _showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.width10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "settings account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const ListTile(
                      leading: CircleAvatar(child: Icon(Icons.person)),
                      title: Text("username"),
                      subtitle: Text("venganncoco@gmail.com"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("logout"),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: Dimensions.width5,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

//
void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Builder(builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            color: Colors.transparent,
            child: const DialogShow(),
          ),
        );
      });
    },
  );
}
