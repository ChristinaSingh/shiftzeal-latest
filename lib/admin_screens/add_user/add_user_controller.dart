import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiftzeal/admin_screens/choose_positions/choose_positions_screen.dart';
import 'package:shiftzeal/admin_screens/publish_shifts_list/publish_shifts_list_screen.dart';
import 'package:shiftzeal/common/navigation_methos.dart';

class AddUserController extends ChangeNotifier {
  bool inAsyncCall = true;

  clickOnSaveButton({required BuildContext context}) {}
  clickAddUserIcon({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: PublishShiftsListScreen());
  }

  clickAddPositionIcon({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: ChoosePositionsScreen());
  }
}
