import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/navigation_methos.dart';
import '../add_shift/add_shift_screen.dart';
import '../choose_positions/choose_positions_screen.dart';
import '../publish_shifts_list/publish_shifts_list_screen.dart';

class AdminSendMessageController extends ChangeNotifier {
  bool inAsyncCall = true;



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
