import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiftzeal/apis/api_models/get_profile_model.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/edit_profile/edit_profile_screen.dart';

import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';

class SettingController extends ChangeNotifier {
  int selectedValue = 0;
  bool inAsyncCall = true;
  bool isTimeForMyShift = false;
  int selectedTimeForMyShiftIndex = 0;
  bool isTime = false;
  int selectedTimeIndex = 0;
  UserData? userData;

  final List<Map<String, String>> cards = [
    {"title": "Time-Off Request Status"},
    {"title": "Swap/Drop Requests"},
    {"title": "OpenShift Requests"},
    {"title": "Schedule Updates"},
    {"title": "Clock In/Out Reminders"},
  ];

  final List<String> toggles = [
    "Time-off Approved Notifications",
    "Schedule Updated Notifications",
    "Clock In/Out Notifications",
  ];

  final List<String> timeList = [
    '11:00p   05:00p',
    '11:15p   05:15p',
    '11:30p   05:30p',
    '11:45p   05:45p',
    '12:00p   06:00p',
    '12:15p   06:15p',
    '12:30p   06:30p',
    '12:45p   06:45p',
    '01:00p   07:00p',
    '01:15p   07:15p',
  ];

  final List<String> timeForMyShift = [
    '0 hours before my shift',
    '1 hours before my shift',
    '2 hours before my shift',
    '3 hours before my shift',
    '4 hours before my shift',
    '5 hours before my shift',
    '6 hours before my shift',
    '7 hours before my shift',
    '8 hours before my shift',
    '9 hours before my shift',
    '10 hours before my shift',
    '11 hours before my shift',
    '12 hours before my shift',
  ];

  List<Map<String, String>> listOfData = [
    {'title': 'Name', 'value': 'Haylie Torff'},
    {'title': 'Phone Number', 'value': 'None'},
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


  Future<void> initMethod({required BuildContext context}) async {
    getProfileApi(context: context);
    notifyListeners();
  }




  getProfileApi({required BuildContext context}) async {
    GetProfileModel? userModel = await ApiMethods.getProfile(
        context: context, bodyParams: {});
    if (userModel != null && userModel.data?.userData != null) {
      userData = userModel.data?.userData!;
      notifyListeners();
    } else {
      CommonWidgets.showMyToastMessage(
          userModel?.message ?? 'Something went wrong');
    }
    inAsyncCall = false;
    notifyListeners();
  }

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

  clickOnTimeForMyShift() {
    isTimeForMyShift = !isTimeForMyShift;
    notifyListeners();
  }

  clickOnTime() {
    isTime = !isTime;
    notifyListeners();
  }

  onSelectedTimeForMyShiftIndexChanged({required int index}) {
    selectedTimeForMyShiftIndex = index;
    notifyListeners();
  }

  onSelectedTimeIndexChanged({required int index}) {
    selectedTimeIndex = index;
    notifyListeners();
  }
}
