import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/components/dialog_show.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/routes/route_helper.dart';
import 'package:task_remind_offline/utils/app_color.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

// ignore: must_be_immutable
class DetailTaskPage extends StatelessWidget {
  bool isNotiClicked;
  final Task? task;

  DetailTaskPage({
    super.key,
    this.task,
    this.isNotiClicked = false,
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Get.toNamed(RouteHelper.getCalenderPage());
            if (isNotiClicked) {
              Get.toNamed(RouteHelper.getSplashPage());
            } else {
              Get.find<CalendarPageController>().getTaskFromTaskController();
              Get.back();
            }
          },
          icon: const Icon(Icons.close_outlined),
        ),
        title: SimpleText(
          text: "title_text_detailPage".tr,
          sizeText: dimensions.fontSize15 * 1.5,
          fontWeight: FontWeight.w500,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //      // _showBottomSheet(context, task!);
        //     },
        //     icon: const Icon(Icons.edit),
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.all(dimensions.width10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: dimensions.width20 * 2,
                  height: dimensions.width20 * 2,
                  decoration: BoxDecoration(
                    color: task!.color == 0
                        ? AppColor.bluishClr
                        : task!.color == 1
                            ? AppColor.pinkClr
                            : AppColor
                                .yellowClr, // this will be dynmaic color follow task
                    borderRadius: BorderRadius.circular(dimensions.radius10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: dimensions.width10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text: task!.title!,
                        sizeText: dimensions.fontSize15,
                        fontWeight: FontWeight.w500,
                      ),
                      // date
                      Row(
                        children: [
                          SimpleText(
                            text: task!.date!,
                            sizeText: dimensions.fontSize15,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: dimensions.height10),
            //
            Row(
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: dimensions.width10),
                SimpleText(
                  text: "${task!.remind!} ${"text_min_before_detailPage".tr}",
                  sizeText: dimensions.fontSize15,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            // note
            Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  size: dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: dimensions.width10),
                SimpleText(
                  text: task!.note!,
                  sizeText: dimensions.fontSize15,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: dimensions.height5),
            // time
            Row(
              children: [
                // start time and end time
                Icon(
                  Icons.access_time_outlined,
                  size: dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: dimensions.width10),
                Expanded(
                  child: SimpleText(
                    text:
                        "${"text_startTime".tr}: ${task!.startTime!} - ${"text_endTime".tr}: ${task!.endTime}",
                    sizeText: dimensions.fontSize15,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            // text repeat
            Row(
              children: [
                Icon(
                  Icons.repeat_one_outlined,
                  size: dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: dimensions.width10),
                SimpleText(
                  text: "${"text_repeat".tr}: ${task!.repeat}",
                  sizeText: dimensions.fontSize15,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            // text task complete
            Row(
              children: [
                Icon(
                  Icons.check_outlined,
                  size: dimensions.iconSize17 * 1.7,
                ),
                SizedBox(width: dimensions.width10),
                SimpleText(
                  text:
                      // ignore: unnecessary_string_interpolations
                      "${task!.isCompleted! == 1 ? 'text_task_complete'.tr : 'text_task_not_complete'.tr}",
                  sizeText: dimensions.fontSize15,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
void _showBottomSheet(BuildContext context, Task task) {
  // Task task = Task(
  //   id: eTask.eventId,
  //   isCompleted: eTask.status,
  //   title: eTask.title,
  //   date: eTask.date,
  //   remind: int.parse(eTask.remind!),
  //   note: eTask.note,
  //   startTime: eTask.startTime,
  //   endTime: eTask.endTime,
  //   color: eTask.color,
  //   repeat: eTask.repeat,
  // );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Builder(builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            color: Colors.transparent,
            child: DialogShow(
              isForUpdate: true,
              task: task,
            ),
          ),
        );
      });
    },
  );
}
