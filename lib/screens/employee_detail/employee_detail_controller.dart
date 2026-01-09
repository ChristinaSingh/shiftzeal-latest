import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/edit_profile/edit_profile_screen.dart';

class EmployeeDetailController extends ChangeNotifier {
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

  clickOnEdit({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: EditProfileScreen());
  }
}
