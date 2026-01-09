import 'package:flutter/material.dart';

import '../../common/navigation_methos.dart';

class SuccessfullyController extends ChangeNotifier {
  clickOnBack({required BuildContext context}) {
    NavigationMethods.popMethod(context: context);
  }
}
