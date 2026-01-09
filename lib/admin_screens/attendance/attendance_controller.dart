import 'package:flutter/material.dart';

class AttendanceController extends ChangeNotifier {
  final List<String> dates = [
    "Aug 18–31",
    "Aug 4–17",
    "Jul 7–20",
    "Aug 18–31",
    "Jun 9–22",
    "Aug 18–31",
    "Aug 18–31",
    "Aug 18–31",
    "Aug 18–31",
    "Aug 18–31",
    "Aug 18–31",
    "Aug 18–31",
    "Aug 18–31",
    "Aug 18–31",
    "Aug 18–31",
    "", // Custom icon row
    "", // Custom icon row
  ];

  final int crossAxisCount = 3;

  clickOnTile(
      {required int index,
      required int index2,
      required BuildContext context}) {
    //NavigationMethods.pushMethod(context: context, widget: PayPeriodsScreen());
  }
}
