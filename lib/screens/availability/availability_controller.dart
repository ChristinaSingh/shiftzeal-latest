import 'package:flutter/material.dart';
import 'package:shiftzeal/screens/add_preference/add_preference_screen.dart';

import '../../admin_screens/publish_shifts/publish_shifts_screen.dart';
import '../../common/navigation_methos.dart';

class AvailabilityController extends ChangeNotifier {
  int _selectedTabIndex = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void clickOnAddIcon({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const AddPreferenceScreen());
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
