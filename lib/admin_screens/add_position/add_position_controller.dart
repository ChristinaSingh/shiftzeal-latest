import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiftzeal/admin_screens/admin_positions/admin_positions_screen.dart';

import '../../common/navigation_methos.dart';

class AddPositionController extends ChangeNotifier {


  clickOnSaveButton({required BuildContext context}) {}

  clickOnAdd({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: AdminPositionsScreen());
  }
}
