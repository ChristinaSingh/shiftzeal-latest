import 'package:flutter/material.dart';
import 'package:shiftzeal/admin_screens/add_position/add_position_screen.dart';

import '../../common/navigation_methos.dart';

class AdminPositionsController extends ChangeNotifier {

  clickOnListTile({required BuildContext context, required int index}) {
   // NavigationMethods.pushMethod(context: context, widget: TaskDetailScreen());
  }


  clickOnAdd({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: AddPositionScreen());
  }

  clickOnSaveButton({required BuildContext context}) {

  }
}
