import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarSyncController extends ChangeNotifier {
  bool inAsyncCall = true;

  List<Map<String, String>> listOfData = [
    {'title': 'All Day'},
    {'title': 'Time'},
    {'title': 'Repeats'},
  ];

  clickOnNextButton({required BuildContext context}) {}

}
