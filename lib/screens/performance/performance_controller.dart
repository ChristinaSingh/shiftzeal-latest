import 'package:flutter/material.dart';

import '../../common/navigation_methos.dart';

class PerformanceController extends ChangeNotifier {

  double percent = 4.94 / 5;


  clickOnBack({required BuildContext context}) {
    NavigationMethods.popMethod(context: context);
  }
}
