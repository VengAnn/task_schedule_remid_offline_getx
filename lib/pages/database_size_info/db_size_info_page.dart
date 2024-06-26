import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/components/dialogs.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/controller/storage_page_controller/db_size_info_page_controller.dart';
import 'package:task_remind_offline/services/databaseHelper/database_helper.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

class DatabaseInfoPage extends StatefulWidget {
  const DatabaseInfoPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DatabaseInfoPageState createState() => _DatabaseInfoPageState();
}

class _DatabaseInfoPageState extends State<DatabaseInfoPage>
    with SingleTickerProviderStateMixin {
  int touchedIndex = -1;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      // delay a bit to see animation
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      // slide from left to right
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
    Get.put(StoragePageController());
    Get.find<StoragePageController>().getTaskFromStorage();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, Dimensions.height20 * 3),
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
                    Get.find<CalendarPageController>()
                        .getTaskFromTaskController();

                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                SimpleText(
                  text: 'Data Storage',
                  sizeText: Dimensions.fontSize20,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder<StoragePageController>(builder: (storagePageController) {
        int countTaskCompleted = 0;
        int countTaskNotCompleted = 0;
        for (Task task in storagePageController.tasksList) {
          if (task.isCompleted == 1) {
            countTaskCompleted += 1;
          }
          if (task.isCompleted == 0) {
            countTaskNotCompleted += 1;
          }
        }

        int totalTasks = countTaskCompleted + countTaskNotCompleted;
        double percentCompleted =
            totalTasks > 0 ? (countTaskCompleted / totalTasks) * 100 : 0;
        double percentNotCompleted =
            totalTasks > 0 ? (countTaskNotCompleted / totalTasks) * 100 : 0;

        return SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 10,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  },
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 2,
                                centerSpaceRadius: 40,
                                sections:
                                    storagePageController.tasksList.isNotEmpty
                                        ? showingSections(
                                            percentCompleted,
                                            percentNotCompleted,
                                          )
                                        : defaultSection(),
                              ),
                            ),
                          ),
                          FutureBuilder<int>(
                            future: DBHelper.getDatabaseSize(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                int size = snapshot.data ?? 0;
                                String sizeText =
                                    (size / 1024 / 1024).toStringAsFixed(2);
                                return Text(
                                  '$sizeText MB',
                                  style: TextStyle(
                                    fontSize: Dimensions.fontSize15 / 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.height20,
                      right: Dimensions.height20,
                    ),
                    child: SizedBox(
                      width: Dimensions.width20 * 9,
                      height: Dimensions.height20 * 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildIndicator(Colors.yellow, 'Task completed',
                              percentCompleted),
                          SizedBox(height: Dimensions.height5),
                          _buildIndicator(Colors.red, 'Task not completed',
                              percentNotCompleted),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.height20,
                  right: Dimensions.height20,
                ),
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height20 * 9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blue.withOpacity(0.7),
                      Colors.blue.withOpacity(0.3),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.width10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: Dimensions.radius15,
                              backgroundColor: Colors.yellow,
                              child: const Icon(Icons.done),
                            ),
                            SizedBox(width: Dimensions.width5),
                            const SimpleText(
                              text: "Task completed",
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(width: Dimensions.width10),
                            SimpleText(
                              text: "${percentCompleted.toStringAsFixed(1)}%",
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height5),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: Dimensions.radius15,
                              backgroundColor: Colors.red,
                              child: const Icon(Icons.done),
                            ),
                            SizedBox(width: Dimensions.width5),
                            const SimpleText(
                              text: "Task not completed",
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(width: Dimensions.width10),
                            SimpleText(
                              text:
                                  "${percentNotCompleted.toStringAsFixed(1)}%",
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height5),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: Dimensions.radius15,
                              backgroundColor: Colors.blue,
                              child: const Icon(Icons.done),
                            ),
                            SizedBox(width: Dimensions.width5),
                            const SimpleText(
                              text: "Total Tasks",
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(width: Dimensions.width10),
                            SimpleText(
                              text: "$totalTasks",
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height5),
                        GestureDetector(
                          onTap: () {
                            storagePageController.clearStorage();

                            Dialogs.showSnackBar(
                              "Cleared successfully",
                              durationMilliseconds: 700,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: Dimensions.height20 * 2,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                            ),
                            child: const Center(
                              child: SimpleText(
                                text: "Clear Data",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  List<PieChartSectionData> showingSections(
      double percentCompleted, double percentNotCompleted) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize =
          isTouched ? Dimensions.fontSize15 : Dimensions.fontSize15;
      final double radius =
          isTouched ? Dimensions.radius20 * 3 : Dimensions.radius20 * 2;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.yellow,
            value: percentCompleted,
            title:
                '${percentCompleted.toStringAsFixed(1)}%', // formate like #0.0 %
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: const [
                Shadow(color: Colors.black, blurRadius: 2),
              ],
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: percentNotCompleted,
            title: '${percentNotCompleted.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: const [
                Shadow(color: Colors.black, blurRadius: 2),
              ],
            ),
          );
        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> defaultSection() {
    return [
      PieChartSectionData(
        color: Colors.grey,
        value: 100,
        title: 'No Data',
        radius: Dimensions.radius20 * 2,
        titleStyle: TextStyle(
          fontSize: Dimensions.fontSize15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: const [
            Shadow(color: Colors.black, blurRadius: 2),
          ],
        ),
      ),
    ];
  }

  Widget _buildIndicator(Color color, String text, double percent) {
    return Row(
      children: [
        Container(
          width: Dimensions.width20,
          height: Dimensions.height20,
          color: color,
        ),
        SizedBox(width: Dimensions.width10),
        Expanded(
          child: Text(
            '$text: ${percent.toStringAsFixed(1)}%',
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
