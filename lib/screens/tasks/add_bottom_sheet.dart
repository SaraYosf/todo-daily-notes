import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/network/firebase/firebase_manager.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add new task",
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
                hintText: "enter your title task",
                //label: Text("Title"),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26))),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
                hintText: "enter your task description",
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
                selectData();
              },
              child: Text(selectedDate.toString().substring(0, 10))),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  shape: const CircleBorder(
                      side: BorderSide(
                    color: Colors.white,
                    width: 3,
                  ))),
              onPressed: () {
                TaskModel task = TaskModel(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                    title: titleController.text,
                    description: descriptionController.text,
                    date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                FirebaseManager.addTask(task);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("succfully"),
                        content: Text("Your task is added at ${selectedDate.toString().substring(0, 10)}"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("Ok"))
                        ],
                      );
                    });
              },
              child: const Icon(
                Icons.done,
              ))
        ],
      ),
    );
  }

  selectData() async {
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
