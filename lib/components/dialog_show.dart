import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_remind_offline/components/dialogs.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/controller/history_page_controller/history_controller.dart';
import 'package:task_remind_offline/controller/task/task_controller.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';
import 'package:task_remind_offline/utils/app_style.dart';
import 'package:task_remind_offline/utils/dimensions.dart';
import 'package:task_remind_offline/widgets/custom_drop_down_widget.dart';
import 'package:task_remind_offline/widgets/date_or_time_picker_widget.dart';
import 'package:task_remind_offline/widgets/my_button.dart';
import 'package:task_remind_offline/widgets/my_input_textfield_reuseable.dart';
import 'package:task_remind_offline/widgets/simple_text.dart';

// ignore: must_be_immutable
class DialogShow extends StatefulWidget {
  final bool isForUpdate;
  final Task? task; // Add this parameter to pass existing task data

  const DialogShow({
    Key? key,
    this.isForUpdate = false,
    this.task,
  }) : super(key: key);

  @override
  State<DialogShow> createState() => _DialogShowState();
}

class _DialogShowState extends State<DialogShow> {
  // ignore: unused_field
  final TaskController _taskController = Get.put(TaskController());

  late TextEditingController _titleController;
  late TextEditingController _noteController;

  int selectedIndexColor = 0;
  int _selectedRemider = 0;
  String _selectedRepeat = "None";

  late DateTime _selectedStartDateTime;
  late DateTime _selectedEndDateTime;

  List<String> remindList = ["0", "5", "10", "15"];
  // respeat can have more then this like None, Daily, weekly, monthly
  List<String> repeatList = ["None", "Daily"];

  Future<void> _selectDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Localizations.localeOf(context),
    );
    if (picked != null && picked != _selectedStartDateTime) {
      setState(() {
        _selectedStartDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedStartDateTime.hour,
          _selectedStartDateTime.minute,
        );
      });
    }
  }

  Future<void> _selectTimePicker(
      {required BuildContext context, required bool isStart}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          isStart ? _selectedStartDateTime : _selectedEndDateTime),
      initialEntryMode: TimePickerEntryMode.dial,
      cancelText: 'Cancel',
      confirmText: 'OK',
      errorInvalidText: 'Invalid time',
      hourLabelText: 'Hour',
      minuteLabelText: 'Minute',
      helpText: 'Select time',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Localizations.override(
            context: context,
            locale: const Locale('en'),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _selectedStartDateTime = DateTime(
            _selectedStartDateTime.year,
            _selectedStartDateTime.month,
            _selectedStartDateTime.day,
            picked.hour,
            picked.minute,
          );
        } else {
          _selectedEndDateTime = DateTime(
            _selectedEndDateTime.year,
            _selectedEndDateTime.month,
            _selectedEndDateTime.day,
            picked.hour,
            picked.minute,
          );
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _noteController = TextEditingController(text: widget.task?.note ?? '');
    _selectedStartDateTime = widget.task != null
        ? DateTime.parse(widget.task!.date!)
        : DateTime.now();

    _selectedStartDateTime = widget.task != null
        ? DateFormat("yyyy-MM-dd hh:mm a")
            .parse("${widget.task!.date!} ${widget.task!.startTime!}")
        : DateTime.now();

    _selectedEndDateTime = widget.task != null
        ? DateFormat("yyyy-MM-dd hh:mm a")
            .parse("${widget.task!.date!} ${widget.task!.endTime!}")
        : DateTime.now().add(const Duration(hours: 1));

    _selectedRemider = widget.task?.remind ?? 0;
    _selectedRepeat = widget.task?.repeat ?? "None";
    selectedIndexColor = widget.task?.color ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions(context);
    return Container(
      height: MediaQuery.of(context).size.height * 9,
      color: Colors.white,
      padding: EdgeInsets.all(dimensions.width10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Row(
              children: [
                SimpleText(
                  text:
                      widget.isForUpdate ? "Update Task" : "Create a new Task",
                  sizeText: dimensions.fontSize21,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                //btn close
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            //
            MyInputTextFieldReusable(
              title: "Tittle",
              hint: "Enter title here",
              textEditingController: _titleController,
            ),
            MyInputTextFieldReusable(
              title: "Note",
              hint: "Enter note here",
              textEditingController: _noteController,
            ),
            SizedBox(height: dimensions.height10),
            // date picker here
            DateOrTimePickerWidget(
              label: "Select Date",
              onTap: () {
                _selectDatePicker(context);
              },
              selectedDateTime: _selectedStartDateTime,
              show: true,
            ),
            SizedBox(height: dimensions.height10),
            //this Row have two expanded start time and end time
            Row(
              children: [
                Expanded(
                  child: DateOrTimePickerWidget(
                    label: "Start Time",
                    onTap: () {
                      _selectTimePicker(context: context, isStart: true);
                    },
                    selectedDateTime: _selectedStartDateTime,
                  ),
                ),
                // sizedbox
                SizedBox(width: dimensions.width10),
                Expanded(
                  child: DateOrTimePickerWidget(
                    label: "End Time",
                    onTap: () {
                      _selectTimePicker(context: context, isStart: false);
                    },
                    selectedDateTime: _selectedEndDateTime,
                  ),
                ),
              ],
            ),
            //Remind
            CustomDropdownWidget(
              textTitle: "Remind",
              items: remindList,
              initialSelectedItem: remindList.first,
              onChanged: (value) {
                setState(() {
                  _selectedRemider = int.parse(value!);
                });
              },
            ),
            //Repeat
            CustomDropdownWidget(
              textTitle: "Repeat",
              items: repeatList,
              initialSelectedItem: repeatList.first,
              onChanged: (value) {
                setState(() {
                  _selectedRepeat = value!;
                });
              },
            ),

            // add a bit space
            SizedBox(height: dimensions.height20),
            // btn create new task and color palette
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _colorPallet(dimensions),
                // button create Task
                MyButton(
                  label: widget.isForUpdate ? "Update Task" : "Create Task",
                  ontap: () {
                    _validateDate();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // vilidation
  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      if (_selectedStartDateTime != _selectedEndDateTime) {
        // if isForUpdate is true update the data in local storage
        if (widget.isForUpdate) {
          if (widget.task != null) {
            _updateTaskToDB();

            Get.find<HistoryPageController>().getTaskCompleted();
            Get.find<HistoryPageController>().getTaskNotCompleted();
            Get.find<HistoryPageController>().getTaskFromStorage();
            Get.back();

            Dialogs.showSnackBar("task update successfully");
          } else {
            Dialogs.showSnackBar("task on update is null or empty");
          }
        } else {
          // otherwise isForUpdate is false
          // add to database sqlite local storage
          _addTaskToDB();

          // call this to see what changed immediately like refresh
          Get.find<CalendarPageController>().getTaskFromTaskController();
          Get.find<CalendarPageController>().getDataLocalForAlerNotification();

          Get.back();
          Dialogs.showSnackBar(
            "Add Task successfully😍",
            durationMilliseconds: 800,
          );
        }
      } else {
        Dialogs.showSnackBar("start time and end time can't the same!");
      }
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Dialogs.showSnackBar("All fields are required!");
    }
  }

  _updateTaskToDB() {
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(_selectedStartDateTime);
    Task task = Task(
      id: widget.task!.id,
      note: _noteController.text,
      title: _titleController.text,
      date: formattedDate,
      startTime: DateFormat('hh:mm a').format(_selectedStartDateTime),
      endTime: DateFormat('hh:mm a').format(_selectedEndDateTime),
      remind: _selectedRemider,
      repeat: _selectedRepeat,
      color: selectedIndexColor,
      isCompleted: widget.task!.isCompleted,
    );
    // update to database
    _taskController.updateTask(task);
  }

  _addTaskToDB() async {
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(_selectedStartDateTime);
    Task task = Task(
      note: _noteController.text,
      title: _titleController.text,
      date: formattedDate,
      startTime: DateFormat('hh:mm a').format(_selectedStartDateTime),
      endTime: DateFormat('hh:mm a').format(_selectedEndDateTime),
      remind: _selectedRemider,
      repeat: _selectedRepeat,
      color: selectedIndexColor,
      isCompleted: 0,
    );

    //add to sqflite
    int value = await _taskController.addTask(
      task: task,
    );
    debugPrint("id in db is $value");
  }

  // ColorsPallete select
  _colorPallet(Dimensions dimensions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle(dimensions),
        ),
        //select colors
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) {
              return Padding(
                padding: EdgeInsets.only(right: dimensions.width5 / 2),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexColor = index;
                    });
                  },
                  child: CircleAvatar(
                    radius: dimensions.radius15,
                    backgroundColor: index == 0
                        ? Colors.blue
                        : index == 1
                            ? Colors.pink
                            : Colors.yellow,
                    child: selectedIndexColor == index
                        ? Icon(
                            Icons.done,
                            size: dimensions.height5 * 2.5,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
