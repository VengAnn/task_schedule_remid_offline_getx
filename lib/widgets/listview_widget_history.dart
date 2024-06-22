import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/utils/app_color.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';
import 'package:task_remind_offline/widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class ListviewWidgetHistory extends StatelessWidget {
  final List<Task> tasksLs;

  ListviewWidgetHistory({
    super.key,
    required this.tasksLs,
  });
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
        itemCount: tasksLs.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return TextFormFieldWidget(
              textEditingController: searchTextEditingController,
              hintText: "text_search".tr,
              titleText: "",
              icon: Icons.search_outlined,
              //onChanged: filterTasks,
            );
          }
          final task = tasksLs[index - 1];
          // ignore: avoid_unnecessary_containers
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // date text
                SimpleText(
                  text: task.date!,
                  textColor: 2 == 2 ? Colors.black : Colors.white,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.done_all_outlined,
                    ),
                    SizedBox(width: Dimensions.width5),
                    // start time text
                    SimpleText(
                      text: task.startTime.toString(),
                    ),
                    const Spacer(),
                    // icon more for editing
                    GestureDetector(
                      onTap: () {
                        // _showBottomSheet(context, task);
                      },
                      child: const Icon(Icons.more_vert_outlined),
                    ),
                  ],
                ),
                //
                SizedBox(height: Dimensions.height5),
                //
                Container(
                  padding: EdgeInsets.all(Dimensions.width10),
                  //  width: SizeConfig.screenWidth * 0.78,
                  decoration: BoxDecoration(
                    color: _getBGClr(0),
                    borderRadius: BorderRadius.circular(Dimensions.width10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title text
                            Text(
                              "Title: ${task.title}",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: task.color == 2
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  color: task.color == 2
                                      ? Colors.black
                                      : Colors.grey[200],
                                  size: Dimensions.iconSize17,
                                ),
                                SizedBox(width: Dimensions.width10),
                                // start time text and end time text
                                Text(
                                  "Start: ${task.startTime} - End: ${task.endTime}",
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: Dimensions.fontSize15,
                                    color: task.color == 2
                                        ? Colors.black
                                        : Colors.grey[100],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.height10),
                            // note text
                            Text(
                              "Note: ${task.note}",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15,
                                color: task.color == 2
                                    ? Colors.black
                                    : Colors.grey[100],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10),
                        height: Dimensions.height20 * 2,
                        width: 0.5,
                        color: task.color == 2
                            ? Colors.black
                            : Colors.grey[200]!.withOpacity(0.7),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          task.color == 1 ? "COMPLETED" : "TODO",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15,
                            color: task.color == 2
                                ? Colors.black
                                : Colors.grey[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//
_getBGClr(int no) {
  switch (no) {
    case 0:
      return AppColor.bluishClr;
    case 1:
      return AppColor.pinkClr;
    case 2:
      return AppColor.yellowClr;
    default:
      return AppColor.bluishClr;
  }
}
