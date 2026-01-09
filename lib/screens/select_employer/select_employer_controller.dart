import 'package:flutter/material.dart';
import 'package:shiftzeal/screens/create_your_employer/create_your_employer_screen.dart';
import 'package:shiftzeal/screens/select_your_employer/select_your_employer_screen.dart';

import '../../common/navigation_methos.dart';

class SelectEmployerController extends ChangeNotifier {
  clickOnJoinARegisteredEmployer({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: const SelectYourEmployerScreen());
  }

  clickOnCreateANewEmployer({required BuildContext context}) {
    NavigationMethods.pushMethod(context: context, widget: const CreateYourEmployerScreen());
  }
}
