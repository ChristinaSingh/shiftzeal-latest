import 'package:flutter/material.dart';

class PublishShiftsListController extends ChangeNotifier {
  clickOnListTile({required BuildContext context, required int index}) {
    //NavigationMethods.pushMethod(context: context, widget: TaskDetailScreen());
  }
  List<String> names = [
    "Vinod Rayka",
    "Prince Ngoma",
    "Mahendra Panwar",
    "Amit Sharma",
    "Neha Yadav",
    "Riya Kapoor",
    "Jay Patel",
    "Sonal Desai"
  ];

  List<Color> randomColors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.deepOrange
  ];


  clickOnClockOthersInOrOut({required BuildContext context}) {}
}
