import 'package:flutter/material.dart';

import '../../common/navigation_methos.dart';
import '../select_employer/select_employer_screen.dart';

class FindMyInvitationController extends ChangeNotifier {
  bool isEmail = false;
  FocusNode focusEmail = FocusNode();

  TextEditingController emailController = TextEditingController();

  void startListener() {
    focusEmail.addListener(onFocusChange);
  }

  void onFocusChange() {
    isEmail = focusEmail.hasFocus;
    notifyListeners();
  }

  clickOnCheckForInviteButton({required BuildContext context}) {
    NavigationMethods.pushMethod(
        context: context, widget: const SelectEmployerScreen());
  }
}
