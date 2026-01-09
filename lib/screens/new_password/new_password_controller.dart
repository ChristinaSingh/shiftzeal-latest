import 'package:flutter/material.dart';
import 'package:shiftzeal/apis/api_models/get_update_password_model.dart';
import 'package:shiftzeal/screens/login/login_screen.dart';
import 'package:shiftzeal/screens/otp/otp_screen.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';

class NewPasswordController extends ChangeNotifier {
  bool isPassword = false;
  bool isConPassword = false;
  bool inAsyncCall = false;
  Map<String, String> bodyParam = {};

  FocusNode focusPassword = FocusNode();
  FocusNode focusConPassword = FocusNode();

  bool passwordHide = true;
  bool conPasswordHide = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();

  void startListener() {
    focusPassword.addListener(onFocusChange);
    focusConPassword.addListener(onFocusChange);
  }

  void onFocusChange() {
    isPassword = focusPassword.hasFocus;
    isConPassword = focusConPassword.hasFocus;
    notifyListeners();
  }

  clickOnPasswordEyeButton() {
    passwordHide = !passwordHide;
    notifyListeners();
  }

  clickOnConPasswordEyeButton() {
    conPasswordHide = !conPasswordHide;
    notifyListeners();
  }

  clickOnSendButton({required BuildContext context}) {
    newPasswordAPiCalling(context: context);
  }

  newPasswordAPiCalling({required BuildContext context}) async {
    if (passwordController.text.isNotEmpty &&
        conPasswordController.text.isNotEmpty) {
      inAsyncCall = true;
      notifyListeners();
      bodyParam.addAll({
        ApiKeyConstants.password: passwordController.text,
        ApiKeyConstants.cPassword: conPasswordController.text,
      });
      UpdatedPasswordModel? userModel = await ApiMethods.createNewPassword(
          context: context, bodyParams: bodyParam);
      if (userModel != null &&
          userModel.status != null &&
          userModel.status != "0") {
        CommonWidgets.showMyToastMessage(
            userModel.message ?? 'Something went wrong');
        NavigationMethods.pushAndRemoveUntilMethod(
            context: context, widget: LoginScreen());
      } else {
        CommonWidgets.showMyToastMessage(
            userModel?.message ?? 'Something went wrong');
      }
    } else {
      CommonWidgets.showMyToastMessage('Required all field!');
    }
    inAsyncCall = false;
    notifyListeners();
  }
}
