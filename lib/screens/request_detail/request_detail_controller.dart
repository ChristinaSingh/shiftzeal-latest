import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/edit_profile/edit_profile_screen.dart';

class RequestDetailController extends ChangeNotifier {
  int selectedValue = 0;
  bool inAsyncCall = true;

  List<Map<String, String>> listOfData = [
    {'title': 'Manager Name', 'value': 'Lawrence Bishnoi'},
    {'title': 'Date', 'value': 'Wed, Jan 1, 2025'},
    {'title': 'Time', 'value': 'All Day'},
    {'title': 'Time Off Type', 'value': 'Personal Paid'},
    {'title': 'Total Paid Hours', 'value': '8 Hours'},
    {'title': 'Status', 'value': 'Pending Approval'},
    {'title': 'Message', 'value': 'Traveling'},
    {'title': 'Conversion / Activity', 'value': '2'},
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
