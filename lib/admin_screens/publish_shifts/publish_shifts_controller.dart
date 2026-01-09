import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiftzeal/admin_screens/add_shift/add_shift_screen.dart';
import 'package:shiftzeal/admin_screens/choose_positions/choose_positions_screen.dart';
import 'package:shiftzeal/admin_screens/publish_shifts_list/publish_shifts_list_screen.dart';

import '../../common/navigation_methos.dart';

class PublishShiftsController extends ChangeNotifier {
  bool inAsyncCall = true;

  bool isPublished = true;

  void togglePublish(bool value) {
    isPublished = value;
    notifyListeners();
  }

  clickOnSaveButton({required BuildContext context}) {}
  clickOnAddUserButton({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const PublishShiftsListScreen());
  }

  clickOnAddShiftScreen({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const AddShiftScreen());
  }


  clickOnAddPositionButton({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const ChoosePositionsScreen());
  }
}
