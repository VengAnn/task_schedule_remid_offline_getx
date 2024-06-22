import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/listview_widget_history.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Task> tasksLs = [
    Task(
      title: 'Complete Flutter Tutorial',
      note: 'Finish the Flutter tutorial series on YouTube.',
      date: '2024-06-21',
      startTime: '10:00 AM',
      endTime: '11:30 AM',
      remind: 1,
      repeat: 'Weekly',
      color: 0xFF3366FF,
      isCompleted: 0,
    ),
    Task(
      title: 'Meeting with Client',
      note: 'Discuss project requirements and timeline.',
      date: '2024-06-22',
      startTime: '02:00 PM',
      endTime: '03:00 PM',
      remind: 0,
      repeat: 'None',
      color: 0xFFFF9900,
      isCompleted: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.find<CalendarPageController>().getTaskFromTaskController();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: SimpleText(
            text: 'title_text_histroy'.tr,
            sizeText: Dimensions.fontSize20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: Dimensions.height20 * 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.blue,
                    tabs: [
                      Tab(
                        child: SimpleText(
                          text: "text_task_complete".tr,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Tab(
                        child: SimpleText(
                          text: "text_task_not_complete".tr,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListviewWidgetHistory(
                        tasksLs: tasksLs,
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: const Text("data 1"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
