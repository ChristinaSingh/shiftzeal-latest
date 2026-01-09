import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/date_picker_view.dart';
import '../../common/time_picker_view.dart';

class TimeOffRequestsController extends ChangeNotifier {
  int selectedValue = 0;
  bool passwordHide = true;
  String? selectedTask;
  bool inAsyncCall = true;
  int selectedIndex = 3;
  final hours = [
    '8 Hours',
    '16 Hours',
    '24 Hours',
    '32 Hours',
    '40 Hours',
  ];

  clickOnPasswordEyeButton() {
    passwordHide = !passwordHide;
    notifyListeners();
  }


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

  final List<String> timeOffTypes = [
    'Holiday (paid)',
    'Holiday (unpaid)',
    'Personal (paid)',
    'Personal (unpaid)',
    'Sick (paid)',
    'Sick (unpaid)',
  ];

  TextEditingController timeController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

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

  clickOnDoneButton({required BuildContext context}) {}

  onSelectedItemChanged({required int index}) {
    selectedIndex = index;
    notifyListeners();
  }

  clickOnTime({required BuildContext context}) async {
    TimeOfDay? timeOfDay = await TimePickerView().timePickerView(
      color: Theme.of(context).primaryColor,
      context: context,
    );

    if (timeOfDay != null) {
      final hour = timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod;
      final minute = timeOfDay.minute.toString().padLeft(2, '0');
      final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

      timeController.text = '$hour:$minute $period';
    }
  }


  clickOnDate({required BuildContext context}) async {
    DateTime? dateTime = await PickDate.pickDateView(
        color: Theme.of(context).primaryColor, context: context);
    if (dateTime != null) {
      DateTime dateTime1 = DateTime.parse(dateTime.toString());
      dateController.text = DateFormat('dd-MM-yyyy').format(dateTime1);
      notifyListeners();
    }
  }

  clickOnStart({required BuildContext context}) async {
    DateTime? dateTime = await PickDate.pickDateView(
        color: Theme.of(context).primaryColor, context: context);
    if (dateTime != null) {
      DateTime dateTime1 = DateTime.parse(dateTime.toString());
      startController.text = DateFormat('dd-MM-yyyy').format(dateTime1);
      notifyListeners();
    }
  }

  clickOnEnd({required BuildContext context}) async {
    DateTime? dateTime = await PickDate.pickDateView(
        color: Theme.of(context).primaryColor, context: context);
    if (dateTime != null) {
      DateTime dateTime1 = DateTime.parse(dateTime.toString());
      endController.text = DateFormat('dd-MM-yyyy').format(dateTime1);
      notifyListeners();
    }
  }
}
