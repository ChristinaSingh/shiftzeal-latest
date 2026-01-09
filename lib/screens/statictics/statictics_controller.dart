import 'package:flutter/material.dart';
import 'package:shiftzeal/common/navigation_methos.dart';
import 'package:shiftzeal/screens/summarize/summarize_screen.dart';

class StaticticsController extends ChangeNotifier {

  clickOnSubmitNewReport({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: SummarizeScreen());
  }
}
