import 'package:flutter/material.dart';
import 'package:shiftzeal/apis/api_models/get_verify_model.dart';
import 'package:shiftzeal/common/common_widgets.dart';

import '../../apis/api_constants/api_key_constants.dart';
import '../../apis/api_methods/api_methods.dart';
import '../../common/navigation_methos.dart';
import '../new_password/new_password_screen.dart';

class OtpController extends ChangeNotifier {
  TextEditingController pin = TextEditingController();
  bool inAsyncCall = false;
  Map<String, String> bodyParam = {};

  clickOnSendButton({required BuildContext context}) {
    otpVerifyAPiCalling(context: context);
  }

  otpVerifyAPiCalling({required BuildContext context}) async {
    if (pin.text.isNotEmpty) {
      inAsyncCall = true;
      notifyListeners();
      bodyParam.addAll({ApiKeyConstants.otp: pin.text});
      VerifyOtpModel? userModel =
          await ApiMethods.verifyOtp(context: context, bodyParams: bodyParam);
      if (userModel != null &&
          userModel.status != null &&
          userModel.status != "0") {
        CommonWidgets.showMyToastMessage(
            userModel.message ?? 'Something went wrong');
        Map<String, String> data = {
          ApiKeyConstants.userId: userModel.data?.userId.toString() ?? "",
        };

        NavigationMethods.pushMethod(
            context: context,
            widget: NewPasswordScreen(
              bodyParam: data,
            ));
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
