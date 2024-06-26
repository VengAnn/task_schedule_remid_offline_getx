import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_remind_offline/components/dialog_show.dart';
import 'package:task_remind_offline/components/my_drawer.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/pages/detail_page/detail_page.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    super.key,
  });

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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.7),
                          Colors.blue.withOpacity(0.3),
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
                          child: ShowCalendar(),
                        )
                      : calendarPageController.calendarView == CalendarView.day
                          ? const Expanded(
                              child: ShowCalendar(),
                            )
                          :
                          // calendar view month show a bit heigth
                          const Expanded(
                              child: SizedBox(
                                child: ShowCalendar(),
                              ),
                            ),
                ],
              ),
            ],
          ),
        );
      }),
      floatingActionButton: GestureDetector(
        onTap: () {
          _showBottomSheet(context);
        },
        child: Container(
          width: Dimensions.width20 * 3,
          height: Dimensions.height20 * 3,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.grey, Colors.blue, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),
          child: const Center(child: Icon(Icons.add)),
        ),
      ),
    );
  }
}

class ShowCalendar extends StatelessWidget {
  const ShowCalendar({
    Key? key,
  }) : super(key: key);

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      Appointment appointment = calendarTapDetails.appointments![0];

      List<Object>? listObj = appointment.resourceIds;

      List<Task> listTask = [];
      // ignore: unused_local_variable
      for (Object obj in listObj!) {
        if (obj is Task) {
          listTask.add(obj);
        }
      }

      // Find the task that matches the tapped appointment
      Task? tappedTask;
      for (Task task in listTask) {
        if (task.id == appointment.id) {
          tappedTask = task;
          break;
        }
      }
      if (tappedTask != null) {
        Get.to(() => DetailTaskPage(task: tappedTask));
      } else {
        log("No matching task found for the tapped appointment.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarPageController>(
      builder: (calendarPageController) {
        return SfCalendar(
          controller: Get.find<CalendarPageController>().calendarController,
          onTap: (CalendarTapDetails details) {
            if (details.appointments == null || details.appointments!.isEmpty) {
              // No appointments, show modal bottom sheet or other action
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.2,
                    minChildSize: 0.2,
                    maxChildSize: 0.9,
                    expand: false,
                    builder: (context, scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          height: Dimensions.screenHeight,
                          color: Colors.transparent,
                          child: const DialogShow(),
                        ),
                      );
                    },
                  );
                },
              );
            }

            // if not null or empty show on tap on the detail page
            calendarTapped(details);
          },
          allowedViews: const [
            CalendarView.week,
            CalendarView.day,
            CalendarView.month,
          ],
          view: Get.find<CalendarPageController>().calendarView,
          onSelectionChanged: (CalendarSelectionDetails details) {
            // Handle selection change if needed
          },
          dataSource: DataSource(calendarPageController.appointments),
          headerHeight: Dimensions.height20 * 2.5,
          headerStyle: CalendarHeaderStyle(
            backgroundColor: Colors.transparent,
            textAlign: TextAlign.center,
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
          ),
        );
      },
    );
  }
}

//
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
