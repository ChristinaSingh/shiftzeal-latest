import 'package:flutter/material.dart';
import 'package:shiftzeal/common/navigation_methos.dart';

class CreateYourWorkPlaceController extends ChangeNotifier {
  clickOnCreateEmployerButton({required BuildContext context}) {
    NavigationMethods.popMethod(context: context);
  }
}
