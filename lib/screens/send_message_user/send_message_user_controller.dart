import 'package:flutter/material.dart';
import 'package:shiftzeal/common/common_methods.dart';
import 'package:shiftzeal/common/common_widgets.dart';

class SendMessageUserController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  int selectedValue = 0;

  clickOnSearchBar({required BuildContext context}) {}

  clickOnListTile({required BuildContext context, required int index}) {
    selectedValue = index;
    notifyListeners();
    // NavigationMethods.pushMethod(context: context, widget: SendAwardsToScreen());
  }

  clickOnChangeShiftButton({required BuildContext context}) {
    CommonWidgets.showMyToastMessage('Coming soon!');
  }
}
