import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPreferenceController extends ChangeNotifier {
  bool inAsyncCall = true;
  bool inSwith = false;
  bool inSwith2 = false;
  int? selectedTask;

  List<Map<String, String>> listOfData = [
    {'title': 'All Day'},
    {'title': 'Time'},
    {'title': 'Repeats'},
  ];

}
