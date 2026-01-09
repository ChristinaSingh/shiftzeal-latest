import 'package:flutter/material.dart';

import '../../common/navigation_methos.dart';
import '../successfully/successfully_screen.dart';

class SendAwardsToController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  int selectedValue = 0;


  clickOnListTile({required BuildContext context, required int index}) {
    selectedValue = index;
    notifyListeners();
    // NavigationMethods.pushMethod(context: context, widget: SendAwardsToScreen());
  }

  List<Map<String,String>> listOfCards = [
    {'icon': '', 'title': 'The Solution Maker Award'},
    {'icon': '', 'title': 'Heart of Lion Award'},
    {'icon': '', 'title': 'Well Done Award'},
    {'icon': '', 'title': 'Employee of the Month'},
  ];

  clickOnSearchBar({required BuildContext context}) {}

  clickOnListTile3({required int index, required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: SuccessfullyScreen());
  }


}
