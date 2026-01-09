import 'package:flutter/material.dart';
import 'package:shiftzeal/apis/api_models/get_password_reset_model.dart';
import 'package:shiftzeal/screens/otp/otp_screen.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/common_widgets.dart';
import '../../common/navigation_methos.dart';

class ForgotPasswordController extends ChangeNotifier {
  bool isEmail = false;
  bool isPhone = false;
  FocusNode focusEmail = FocusNode();
  FocusNode focusPhone = FocusNode();
  bool inAsyncCall = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void startListener() {
    focusEmail.addListener(onFocusChange);
    focusPhone.addListener(onFocusChange);
  }

  void onFocusChange() {
    isEmail = focusEmail.hasFocus;
    isPhone = focusPhone.hasFocus;
    notifyListeners();
  }

  clickOnSendButton({required BuildContext context}) {
    passwordResitAPiCalling(context: context);
  }

  passwordResitAPiCalling({required BuildContext context}) async {
    if (emailController.text.isNotEmpty || phoneController.text.isNotEmpty) {
      inAsyncCall = true;
      notifyListeners();
      Map<String, String> bodyParam = {
        ApiKeyConstants.identity : emailController.text ?? phoneController.text ,
      };
      PasswordResetModel? userModel = await ApiMethods.passwordReset(
          context: context, bodyParams: bodyParam);
      if (userModel != null &&
          userModel.status != null &&
          userModel.status != "0") {
        CommonWidgets.showMyToastMessage(
            userModel.message ?? 'Something went wrong');
        NavigationMethods.pushAndRemoveUntilMethod(
            context: context, widget:  OtpScreen(bodyParam: bodyParam,));
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
