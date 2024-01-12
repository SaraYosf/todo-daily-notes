import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/tasks/task_item.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';
import 'package:todo/shared/style/colors.dart';
import '../../models/task_model.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate=date;
            setState(() {

            });
          },
          leftMargin: 20,
          monthColor: primary,
          dayColor: Colors.black26,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primary,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<TaskModel>>(
              stream: FirebaseManager.getTask(selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("something error"),
                  );
                }
                List<TaskModel> tasks = snapshot.data?.docs.map((e) =>
                    e.data()).toList()??[];
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(tasks[index],);
                  },
                  itemCount: tasks.length,
                );
              },
            )
        )
      ],
    );
  }
}
