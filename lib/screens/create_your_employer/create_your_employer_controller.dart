import 'package:flutter/material.dart';
import 'package:shiftzeal/common/navigation_methos.dart';

class CreateYourEmployerController extends ChangeNotifier {
  clickOnCreateEmployerButton({required BuildContext context}) {
    NavigationMethods.popMethod(context: context);
  }
}
