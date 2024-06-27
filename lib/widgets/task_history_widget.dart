import 'package:flutter/material.dart';

import 'package:task_remind_offline/components/dialog_show.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/utils/app_color.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class TaskHistoryWidget extends StatelessWidget {
  final Task task;

  const TaskHistoryWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: dimensions.width5 * 2),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: dimensions.width10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            text: task.date!,
            textColor: task.color == 2 ? Colors.black : Colors.white,
          ),
          Row(
            children: [
              const Icon(
                Icons.done_all_outlined,
              ),
              SizedBox(width: dimensions.width5),
              SimpleText(text: task.startTime!),
              const Spacer(),
              // icon more for editing
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context, task);
                },
                child: const Icon(Icons.more_vert_outlined),
              ),
            ],
          ),
          SizedBox(height: dimensions.height5),
          //
          Container(
            padding: EdgeInsets.all(dimensions.width10),
            //  width: SizeConfig.screenWidth * 0.78,
            decoration: BoxDecoration(
              color: _getBGClr(task.color ?? 0),
              borderRadius: BorderRadius.circular(dimensions.width10),
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
                      Text(
                        task.title ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: task.color == 2 ? Colors.black : Colors.white,
                        ),
                      ),
                      SizedBox(height: dimensions.height10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: task.color == 2
                                ? Colors.black
                                : Colors.grey[200],
                            size: dimensions.iconSize17,
                          ),
                          SizedBox(width: dimensions.width10),
                          Text(
                            "${task.startTime} - ${task.endTime}",
                            style: TextStyle(
                              fontSize: dimensions.fontSize15,
                              color: task.color == 2
                                  ? Colors.black
                                  : Colors.grey[100],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: dimensions.height10),
                      Text(
                        task.note ?? "",
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              task.color == 2 ? Colors.black : Colors.grey[100],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: dimensions.width10),
                  height: dimensions.height20 * 2,
                  width: 0.5,
                  color: task.color == 2
                      ? Colors.black
                      : Colors.grey[200]!.withOpacity(0.7),
                ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    task.isCompleted == 1 ? "COMPLETED" : "TODO",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: task.color == 2 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
}

//
void _showBottomSheet(BuildContext context, Task task) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Builder(
        builder: (context) {
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
        },
      );
    },
  );
}
