import 'package:flutter/material.dart';
import 'package:todo/screens/tasks/add_bottom_sheet.dart';
import 'package:todo/screens/tasks/tasks_tab.dart';
import '../screens/settings/settings_tab.dart';
import '../shared/style/colors.dart';

class HomeLayouts extends StatefulWidget {
  static const String routeName = "home-layout";
  const HomeLayouts({super.key});
  @override
  State<HomeLayouts> createState() => _HomeLayoutsState();
}

class _HomeLayoutsState extends State<HomeLayouts> {
  int index = 0;
  List<Widget> tabs = [TasksTab(), const SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: mintGreen,
      appBar: AppBar(
        title: const Text("ToDo"),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.white,
        elevation: 0,
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: index,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskBottomSheet();
        },
        shape:
            const CircleBorder(side: BorderSide(color: Colors.white, width: 3)),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: tabs[index],
    );
  }

  addTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const AddBottomSheet());
      },
    );
  }
}
