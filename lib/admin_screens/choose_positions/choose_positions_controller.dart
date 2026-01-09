import 'package:flutter/material.dart';
import 'package:shiftzeal/admin_screens/add_position/add_position_screen.dart';

import '../../common/navigation_methos.dart';

class ChoosePositionsController extends ChangeNotifier {

  int selectedIndex = 0;
  final List<String> roles = [
    'Dsp',
    'Supervisor',
    'Manager',
    'Director',
    'CEO',
    'General Manager',
    'Front Desk',
    'RN',
  ];


  clickOnListTile({required BuildContext context, required int index}) {
    // NavigationMethods.pushMethod(context: context, widget: TaskDetailScreen());
  }

  clickOnAdd({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: AddPositionScreen());
  }
}
