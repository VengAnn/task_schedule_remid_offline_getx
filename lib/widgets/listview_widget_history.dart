import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/components/dialog_show.dart';
import 'package:task_remind_offline/components/dialogs.dart';
import 'package:task_remind_offline/controller/history_page_controller/history_controller.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/services/databaseHelper/database_helper.dart';
import 'package:task_remind_offline/utils/app_color.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';
import 'package:task_remind_offline/widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class ListviewWidgetHistory extends StatefulWidget {
  final List<Task> tasksLs;

  const ListviewWidgetHistory({
    super.key,
    required this.tasksLs,
  });

  @override
  State<ListviewWidgetHistory> createState() => _ListviewWidgetHistoryState();
}

class _ListviewWidgetHistoryState extends State<ListviewWidgetHistory> {
  TextEditingController searchTextEditingController = TextEditingController();
  List<Task> filteredTasks = [];

  @override
  void initState() {
    super.initState();

    filteredTasks = widget.tasksLs;
  }

  void filterTasks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTasks = widget.tasksLs;
      } else {
        filteredTasks = widget.tasksLs
            .where((task) =>
                task.title!.toLowerCase().contains(query.toLowerCase()) ||
                task.note!.toLowerCase().contains(query.toLowerCase()) ||
                task.date!.toLowerCase().contains(query.toLowerCase()) ||
                task.startTime!.toLowerCase().contains(query.toLowerCase()) ||
                task.endTime!.toLowerCase().contains(query.toLowerCase()) ||
                task.remind
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                task.repeat!.toLowerCase().contains(query.toLowerCase()) ||
                task.color
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.tasksLs.isEmpty
        ? const Center(
            child: SimpleText(text: "Data is empty"),
          )
        : ListView.builder(
            itemCount: filteredTasks.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return TextFormFieldWidget(
                  textEditingController: searchTextEditingController,
                  hintText: "text_search".tr,
                  titleText: "",
                  icon: Icons.search_outlined,
                  onChanged: filterTasks,
                );
              }
              final task = filteredTasks[index - 1];
              // ignore: avoid_unnecessary_containers
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // date text
                    SimpleText(
                      text: task.date!,
                      textColor: task.color == 2 ? Colors.black : Colors.white,
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
                            _showBottomSheet(context: context, task: task);
                          },
                          child: const Icon(Icons.more_vert_outlined),
                        ),
                      ],
                    ),
                    //
                    SizedBox(height: Dimensions.height5),
                    //
                    GestureDetector(
                      onLongPress: () {
                        // show bottom sheet for delete task , or update task to complete
                        _showBottomSheet_2_field(context: context, task: task);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.width10),
                        decoration: BoxDecoration(
                          color: _getBGClr(task.color!),
                          borderRadius:
                              BorderRadius.circular(Dimensions.width10),
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
                                      fontSize: Dimensions.fontSize15,
                                      fontWeight: FontWeight.bold,
                                      color: task.color == 2
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      fontSize: Dimensions.fontSize15,
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
                                  fontSize: Dimensions.fontSize15,
                                  color: task.color == 2
                                      ? Colors.black
                                      : Colors.grey[100],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
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

//
void _showBottomSheet({required BuildContext context, required Task task}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Builder(builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            color: Colors.transparent,
            child: DialogShow(isForUpdate: true, task: task),
          ),
        );
      });
    },
  );
}

//
// ignore: non_constant_identifier_names
_showBottomSheet_2_field({required BuildContext context, required Task task}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Builder(builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(height: Dimensions.height5),
                Container(
                  width: Dimensions.width20 * 3,
                  height: Dimensions.height10,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(Dimensions.width10),
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                ContinerWidgetUpdateAndDelete(
                  ontap: () async {
                    await DBHelper.delete(task);

                    // get to refresh page to see what changed
                    Get.find<HistoryPageController>().getTaskCompleted();
                    Get.find<HistoryPageController>().getTaskNotCompleted();
                    Get.find<HistoryPageController>().getTaskFromStorage();
                    Get.back();

                    Dialogs.showSnackBar("Delte task successfully");
                  },
                  text: "Delete Task",
                ),
                //
                SizedBox(height: Dimensions.height5),
                ContinerWidgetUpdateAndDelete(
                  ontap: () async {
                    Task taskNew = Task(
                      id: task.id,
                      title: task.title,
                      startTime: task.startTime,
                      endTime: task.endTime,
                      note: task.note,
                      color: task.color,
                      date: task.date,
                      remind: task.remind,
                      repeat: task.repeat,
                      isCompleted: 1, // update to completed
                    );
                    await DBHelper.update(taskNew.id!);

                    Get.find<HistoryPageController>().getTaskCompleted();
                    Get.find<HistoryPageController>().getTaskNotCompleted();
                    Get.find<HistoryPageController>().getTaskFromStorage();
                    Get.back();

                    Dialogs.showSnackBar("update to completed successfully");
                  },
                  text: "Update Task to Complete",
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}

class ContinerWidgetUpdateAndDelete extends StatelessWidget {
  final VoidCallback ontap;
  final String text;

  const ContinerWidgetUpdateAndDelete({
    super.key,
    required this.ontap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
        width: double.maxFinite,
        height: Dimensions.height20 * 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: SimpleText(
            text: text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
