import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiftzeal/common/common_widgets.dart';

import '../../common/navigation_methos.dart';

class AddDocumentController extends ChangeNotifier {
  clickOnSubmitButton({required BuildContext context}) {
    NavigationMethods.popMethod(context: context);
    CommonWidgets.showMyToastMessage('Coming soon!');
  }
}
