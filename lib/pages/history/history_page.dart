import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/components/loading_custom.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/controller/history_page_controller/history_controller.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/listview_widget_history.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryPageController());
    return DefaultTabController(
      length: 2,
      child: GetBuilder<HistoryPageController>(
        builder: (historyPageController) {
          return historyPageController.isLoading
              ? Container(
                  color: Colors.white,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: const LoadingCustom())
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize:
                        Size(double.maxFinite, Dimensions.height20 * 3),
                    child: SafeArea(
                      child: Container(
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
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();

                                Get.find<CalendarPageController>()
                                    .getTaskFromTaskController();
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                            SimpleText(
                              text: 'title_text_histroy'.tr,
                              sizeText: Dimensions.fontSize20,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
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
                                // list view for task completed
                                ListviewWidgetHistory(
                                  tasksLs: historyPageController.completedLs,
                                ),
                                // task not complete
                                ListviewWidgetHistory(
                                  tasksLs: historyPageController.notCompletedLs,
                                ),
                              ],
                            ),
                          )
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
