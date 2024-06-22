import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_remind_offline/controller/calendar/calendare_page_controller.dart';
import 'package:task_remind_offline/services/databaseHelper/database_helper.dart';
import 'package:task_remind_offline/models/task_sqlite/task_model.dart';

class DatabaseInfoPage extends StatefulWidget {
  const DatabaseInfoPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DatabaseInfoPageState createState() => _DatabaseInfoPageState();
}

class _DatabaseInfoPageState extends State<DatabaseInfoPage> {
  Future<void> _insertSampleData() async {
    Task task1 = Task(
      title: 'Sample Task 1',
      note: 'This is a sample task inserted for testing.',
      date: '2024-06-21',
      startTime: '10:00 AM',
      endTime: '11:00 AM',
      remind: 0,
      repeat: 'None',
      color: 0,
      isCompleted: 0,
    );

    Task task2 = Task(
      title: 'Sample Task 2',
      note: 'Another sample task for testing purposes.',
      date: '2024-06-22',
      startTime: '11:00 AM',
      endTime: '12:00 PM',
      remind: 0,
      repeat: 'Daily',
      color: 1,
      isCompleted: 0,
    );

    await DBHelper.dbInsert(task1);
    await DBHelper.dbInsert(task2);
    setState(() {
      DBHelper.getDatabaseSize();
    });
  }

  // Method to clear all data from the database
  Future<void> _clearDatabase() async {
    await DBHelper.clearDatabase();
    setState(() {
      DBHelper.getDatabaseSize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.find<CalendarPageController>().getTaskFromTaskController();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Database Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                _insertSampleData();
              },
              child: const Text('Insert Sample Data'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _clearDatabase();
              },
              child: const Text("clear data"),
            ),
            const SizedBox(height: 16),
            FutureBuilder<int>(
              future: DBHelper.getDatabaseSize(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  int size = snapshot.data ?? 0;
                  return Text(
                    'Database Size: ${(size / (1024 * 1024)).toStringAsFixed(2)} MB',
                    style: const TextStyle(fontSize: 18),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
