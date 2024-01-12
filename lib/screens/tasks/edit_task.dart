
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';

import '../../models/task_model.dart';

class EditTask extends StatefulWidget {
  TaskModel task;
  EditTask({required this.task,super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var selectedDate =DateTime.now();
@override
  void initState() {
  titleController.text=widget.task.title;
  descriptionController.text=widget.task.description;
selectedDate=DateTime.fromMillisecondsSinceEpoch(widget.task.date);

  super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container (padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      height:500 ,
      child: Column(

        children: [ Text(
          "Add new task",
          style:
          GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
        ),
          TextFormField(

            controller: titleController,
            decoration: const InputDecoration(

                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26))),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
                //label: Text("Title"),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26))),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("select data",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18))),
          InkWell(
              onTap: () {
                SelectData();
              },
              child: Text(selectedDate.toString().substring(0, 10))),
          const SizedBox(
            height: 30,
          ),
        ElevatedButton(onPressed: (){
          TaskModel taskModel=TaskModel(
              userId: FirebaseAuth.instance.currentUser!.uid,
              title: titleController.text,id: widget.task.id,
              isDone: widget.task.isDone,
              description: descriptionController.text,
              date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch
          );
          FirebaseManager.updateTask(taskModel);
          Navigator.pop(context);
        }, child: const Text("OK"))],
      ),),
    );
  }

  SelectData() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 9000)));
    if (chosenDate == null) return;
    selectedDate = chosenDate;
    setState(() {

    });
  }
}
