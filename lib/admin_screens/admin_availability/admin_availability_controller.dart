import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiftzeal/admin_screens/add_position/add_position_screen.dart';

import '../../common/navigation_methos.dart';
import '../../screens/add_preference/add_preference_screen.dart';

class AdminAvailabilityController extends ChangeNotifier {
  int _selectedTabIndex = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void clickOnAddIcon({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const AddPositionScreen());
  }

  SchedulerProvider() {
    _selectedDay = _focusedDay;
  }

  int get selectedTabIndex => _selectedTabIndex;

  DateTime get focusedDay => _focusedDay;

  DateTime? get selectedDay => _selectedDay;

  void changeTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  void selectDay(DateTime selected, DateTime focused) {
    _selectedDay = selected;
    _focusedDay = focused;
    notifyListeners();
  }

  addIcon({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const AddPreferenceScreen());
  }
}
