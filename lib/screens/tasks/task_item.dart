import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';
import 'package:todo/shared/style/colors.dart';

import 'edit_task.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem(this.taskModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(

          ),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseManager.deleteTask(taskModel.id);
              },
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12),
                  topLeft: Radius.circular(12)),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => EditTask(task: taskModel),),
                );
              },
              backgroundColor: primary,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'edit',
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 9,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              Column(
                children: [
                  Text(taskModel.title, style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )),
                  Text(taskModel.description, style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400))
                ],
              ),
              const SizedBox(width: 30),

              InkWell(
                onTap: () {
                  FirebaseManager.updateIsDone(taskModel.id, true);
                },
                child: Container(
                  width: 65,
                  height: 30,
                  decoration: BoxDecoration(
                    color: taskModel.isDone ? Colors.green : Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: taskModel.isDone
                      ? const Center(child: Text("done",
                    style: TextStyle(color: Colors.white, fontSize: 20),))
                      : const Icon(Icons.done, color: Colors.white, size: 30,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
