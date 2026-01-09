import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiftzeal/screens/add_request/add_request_screen.dart';
import 'package:shiftzeal/screens/request_detail/request_detail_screen.dart';

import '../../common/navigation_methos.dart';

class RequestsController extends ChangeNotifier {
  int selectedValue = 0;
  bool inAsyncCall = true;

  List<Map<String, String>> listOfData = [
    {'title': 'Name', 'value': 'Haylie Torff'},
    {'title': 'Phone', 'value': 'None'},
    {'title': 'Email', 'value': 'None'},
    {'title': 'Employee ID', 'value': 'None'},
    {'title': 'Role', 'value': 'Employee'},
    {'title': 'Max Hours/Week', 'value': 'None'},
    {'title': 'Privacy', 'value': 'None'},
    {'title': 'Two-Step Verification', 'value': 'None'},
    {'title': 'Timezone', 'value': 'None'},
  ];

  List<Map<String, String>> listOfDataAlert = [
    {'title': 'Time-Off Request Status'},
    {'title': 'Swap/Drop Requests'},
    {'title': 'Open Shift Requests'},
    {'title': 'Schedule Updates'},
    {'title': 'Clock In/Out Reminders'},
  ];

  List<Map<String, String>> listOfDataAlert2 = [
    {'title': 'Clock In/Out Reminders'},
    {'title': 'Badge App Icon'},
    {'title': 'In-App Notifications'},
  ];

  List listOfDate = [
    {
      'title': 'Paid time off',
      'des': "Days available 23 Days used",
      'number': '25',
    },
    {
      'title': 'Sick',
      'des': "Days available 35 Days used",
      'number': '5',
    },
    {
      'title': 'Emergency',
      'des': "Days available 25 Days used",
      'number': '10',
    },
    {
      'title': 'Personal Time',
      'des': "Days available 44 Days used",
      'number': '35',
    },
    {
      'title': 'Holidays',
      'des': "Days available 23 Days used",
      'number': '3',
    },
  ];

  getUserTripApiMethod({required BuildContext context}) async {
    inAsyncCall = true;
    notifyListeners();
    inAsyncCall = false;
    notifyListeners();
  }

  clickOnTap({required int value}) {
    selectedValue = value;
    notifyListeners();
  }

  clickOnAddIcon({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: AddRequestScreen());
  }

  clickOnNewRequestItem({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: RequestDetailScreen());
  }
}
